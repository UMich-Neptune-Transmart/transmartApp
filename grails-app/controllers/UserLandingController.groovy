import org.transmart.searchapp.AccessLog
import org.transmart.searchapp.AuthUser
import DataAttestation


class UserLandingController {
    /**
     * Dependency injection for the springSecurityService.
     */
    def springSecurityService

    def index = {
        def user = AuthUser.findByUsername(springSecurityService.getPrincipal().username)
        new AccessLog(username: springSecurityService.getPrincipal().username, event: "Login",
                eventmessage: request.getHeader("user-agent"),
                accesstime: new Date()).save()
        def skip_data_attestation =  grailsApplication.config.com.recomdata?.skipdataattestation?:false;
        if ((!skip_data_attestation) && DataAttestation.needsDataAttestation(user)) {
            redirect(uri: '/dataAttestation/index')
        }
        else {

            def skip_disclaimer = grailsApplication.config.com.recomdata?.skipdisclaimer ?: false;
            if (skip_disclaimer) {
                if (grailsApplication.config.com.recomdata?.defaults?.containsKey("landing"))
                    redirect(uri: grailsApplication.config.com.recomdata.defaults.landing);
                else
                    redirect(uri: '/RWG');
            } else {
                redirect(uri: '/userLanding/disclaimer.gsp')
            }
        }
    }
    def agree = {
        new AccessLog(username: springSecurityService.getPrincipal().username, event: "Disclaimer accepted",
                accesstime: new Date()).save()
        redirect(uri: '/RWG')
    }

    def disagree = {
        new AccessLog(username: springSecurityService.getPrincipal().username, event: "Disclaimer not accepted",
                accesstime: new Date()).save()
        redirect(uri: '/logout')
    }

    def checkHeartBeat = {
        render(text: "OK")
    }
}
