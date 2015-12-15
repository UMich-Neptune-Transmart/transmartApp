-- Across Trials tooltip/definition table

CREATE TABLE "i2b2demodata"."neptune_xtrials_metadata" (
"modifier_cd" varchar(50) COLLATE "default" NOT NULL,
"c_tooltip" varchar(1000) COLLATE "default"
);

-- Modify view to include Across Trials tooltips

CREATE OR REPLACE VIEW "i2b2demodata"."modifier_dimension_view" AS 
SELECT md.modifier_path, md.modifier_cd, md.name_char, md.modifier_blob, md.update_date, md.download_date, md.import_date,
md.sourcesystem_cd, md.upload_id, md.modifier_level, md.modifier_node_type, mm.valtype_cd, mm.std_units,
mm.visit_ind, nm.c_tooltip
FROM ((i2b2demodata.modifier_dimension md
  LEFT JOIN i2b2demodata.modifier_metadata mm ON (((md.modifier_cd)::text = (mm.modifier_cd)::text)))
  LEFT JOIN i2b2demodata.neptune_xtrials_metadata nm ON (((md.modifier_cd)::text = (nm.modifier_cd)::text)));

ALTER TABLE "i2b2demodata"."modifier_dimension_view" OWNER TO "i2b2demodata";

-- Data Attestation Tables and Sequences

CREATE SEQUENCE searchapp.data_attestation_id_seq;

GRANT USAGE, SELECT, UPDATE ON searchapp.data_attestation_id_seq TO biomart_user, searchapp;

CREATE TABLE searchapp.data_attestation  ( 
    data_attestation_id	int8 NOT NULL DEFAULT nextval('searchapp.data_attestation_id_seq'::regclass),
    auth_user_id       	int8 NULL,
    last_date_agreed   	timestamp NULL 
    );

GRANT SELECT, INSERT ON searchapp.data_attestation TO biomart_user, searchapp;

-- Function to load tooltips/hovers and definitions from comma-separated file (non-Across Trials only)

CREATE OR REPLACE FUNCTION "i2b2metadata"."add_tooltips"(IN filename varchar, IN add_frontslashes bool, IN add_endslashes bool)
  RETURNS SETOF "pg_catalog"."text" AS $BODY$

DECLARE 
	num_rows int;
	message TEXT;
	tooltip_row RECORD;
	this_nodepath TEXT;

BEGIN
	SET standard_conforming_strings = ON;
	CREATE TEMP TABLE tooltip(nodepath text, tooltip_text text);
	CREATE TEMP TABLE tooltip_results(nodepath text);
	EXECUTE 'COPY tooltip FROM ' || quote_literal(filename) || ' WITH CSV QUOTE ''"'' HEADER;';

	FOR tooltip_row IN SELECT * FROM tooltip LOOP
		IF add_endslashes THEN
			this_nodepath = tooltip_row.nodepath || '\';
		ELSE
			this_nodepath = tooltip_row.nodepath;
		END IF;

		PERFORM c_fullname FROM i2b2metadata.i2b2 
		WHERE c_fullname = this_nodepath;

		IF FOUND THEN
			UPDATE i2b2metadata.i2b2 
			SET c_tooltip = tooltip_row.tooltip_text
			WHERE c_fullname = this_nodepath;

			PERFORM path FROM i2b2metadata.i2b2_tags
			WHERE path = this_nodepath;

			IF FOUND THEN
				UPDATE i2b2metadata.i2b2_tags
				SET tag = tooltip_row.tooltip_text
				WHERE path = this_nodepath;
			ELSE
				INSERT INTO i2b2metadata.i2b2_tags("path", tag, tag_type, tags_idx)
				VALUES(this_nodepath,tooltip_row.tooltip_text,'Details', 0);				
			END IF;

		ELSE
			INSERT INTO tooltip_results(nodepath) VALUES(this_nodepath);
		END IF;

	END LOOP;
RETURN QUERY EXECUTE 'SELECT * FROM tooltip_results;';
DISCARD TEMP;
END;

$BODY$
  LANGUAGE 'plpgsql' VOLATILE COST 100
 ROWS 1000
;
