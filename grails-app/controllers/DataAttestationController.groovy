
import org.transmart.searchapp.AuthUser
import DataAttestation

import java.text.SimpleDateFormat

class DataAttestationController {

    def springSecurityService

    def index = {
        def user = AuthUser.findByUsername(springSecurityService.getPrincipal().username)
    	if (DataAttestation.needsDataAttestation(user))
            render(view:"attestation")
        else
            redirect(uri:'/RWG/index');
    }
    def agree = {
        def user = AuthUser.findByUsername(springSecurityService.getPrincipal().username)
        DataAttestation.updateOrAddNewAgreementDate(user)
        redirect(uri: '/RWG/index')
    }

    def disagree = {
        redirect(uri: '/logout')
    }

	def clear = {
	    def user = AuthUser.findByUsername(springSecurityService.getPrincipal().username)
    	def da = DataAttestation.findByAuthUserId(user.id)
    	if (da != null) {
            try {
                da.delete(flush: true)
            }
		    catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "Could not delete user ${user}"
            }
        }
        redirect(uri: '/logout')		
	}    
}
