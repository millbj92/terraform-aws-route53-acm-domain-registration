

variable "subject_alternative_name_prefixes" {
  description = "Alternative names for the domain. Wildcards may be used. (*.example.com, etc)"
  type        = list(string)
  default     = ["www", "*", "*.dev", "*.stg"]
}

variable "hosted_zone" {
  description = "Route53 Hosted Zone"
  type        = string
}

variable "region" {
  description = "region"
  type        = string
}

variable "tags" {
  description = "Extra tags to be set on your "
  type        = map(string)
  default = {
    #Suggestions:

    #Local Scope
    #"info:developerEmail"                 = "example@examplecompany.com"
    #"info:buildID"                        = "__devOpsBuildID__"
    #"info:time"                           = timestamp()
    #Project Scope
    #"myorg:projectName:projectWebsite"    = "https://github.com/brandonmillerio"
    #"myorg:projectName:projectResources"  = "https://brandonmiller.io/*https://github.com/brandonmillerio*https://github.com/millbj92"

    #Team Scope
    #"myorg:projectName:teamName:teamLead" = "Team Lead name/email"

    #Organization scope
    #"myorg:projectName"                   = "nuboverflow"
    #"myorg:taggingVersion"                = "0.0.1"
  }
}