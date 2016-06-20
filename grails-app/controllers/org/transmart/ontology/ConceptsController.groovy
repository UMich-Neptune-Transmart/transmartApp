package org.transmart.ontology

import grails.converters.JSON
import org.transmart.searchapp.AuthUser

class ConceptsController {

    def conceptsResourceService
    def i2b2HelperService
    def springSecurityService

    def getCategories() {
        render conceptsResourceService.allCategories as JSON
    }

    def getChildren() {
        def user = AuthUser.findByUsername(springSecurityService.getPrincipal().username)
        def parentConceptKey = params.get('concept_key')
        def parent = conceptsResourceService.getByKey(parentConceptKey)
        def childrenWithTokens = i2b2HelperService.getChildPathsWithTokensFromParentKey(parentConceptKey)
        def childrenWithAuth = i2b2HelperService.getAccess(childrenWithTokens, user)
        def authChildren = []

        parent.children.each { child->
            if (childrenWithAuth[child.fullName] != 'Locked') {
               authChildren.add(child)
            }
        }

        render authChildren as JSON
    }

}
