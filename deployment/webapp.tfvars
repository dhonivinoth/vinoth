##We need to provide options and conditions for creating web application deployments.
##The webapp also condition based and user's choice.(windows webapp,linux webapp,container webapp for linux,container webapp for windows##

SUBSCRIPTION_NAME          = "Free Trial"
RG_LOCATION                = "East Us"    #default
APP_SERVICE_PLAN_NAME      = "asp-dev-eau-001"  # We need to use Existing App service plan for Webapp(App service)
APP_SERVICE_PLAN_RG_NAME   = "firstrg701" #Existing Resource Group
APP_SERVICE_NAME           = "webapptest701"
APP_SERVICE_RG_NAME        = "secondrg701"
APP_SERVICE_LOCATION       = "East Us"     #default
TEAM_MEMBERS               = {
  "Ravi"             = "ravi@gmail.com"
  "Siva"             = "siva@gmail.com"
  "Vinoth"           = "vinoth@gmail.com"
}
