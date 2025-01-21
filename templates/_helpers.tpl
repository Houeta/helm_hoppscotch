{{/* vim set filetype=mustache: */}}

{{/*
Return the proper service name for Hoppscotch admin controller
*/}}
{{- define "hoppscotch.admin" -}}
    {{- printf "%s-admin" (include "common.names.fullname" .) | trunc 63 | trimSuffix "-" }}
{{- end -}} 

{{/*
Return the proper service name for Hoppscotch backend controller
*/}}
{{- define "hoppscotch.backend" -}}
    {{- printf "%s-backend" (include "common.names.fullname" .) | trunc 63 | trimSuffix "-" }}
{{- end -}} 

{{/*
Return the proper service name for Hoppscotch frontend controller
*/}}
{{- define "hoppscotch.frontend" -}}
    {{- printf "%s-frontend" (include "common.names.fullname" .) | trunc 63 | trimSuffix "-" }}
{{- end -}} 

{{/*
Return the proper service name for Hoppscotch proxy controller
*/}}
{{- define "hoppscotch.proxy" -}}
    {{- printf "%s-proxy" (include "common.names.fullname" .) | trunc 63 | trimSuffix "-" }}
{{- end -}} 

{{/*
Return the proper name of env cm/secret resource
*/}}
{{- define "hoppscotch.envvars" -}}
    {{- printf "%s-envvars" (include "common.names.fullname" .) | trunc 63 | trimSuffix "-" }}
{{- end -}} 

{{/*
Return the proper name of basic-auth secret resource
*/}}
{{- define "hoppscotch.basicAuth" -}}
    {{- printf "%s-basic-auth" (include "common.names.fullname" .) | trunc 63 | trimSuffix "-" }}
{{- end -}} 


{{/*
Get web protocol name 
*/}}
{{- define "hoppscotch.getWebPrtcl" -}}
{{- if .Values.ingress.tls }}
  {{- printf "https" }}
{{- else -}}
  {{- printf "http" }}
{{- end -}}
{{- end -}}

{{/*
Get full name image with tag/digest
*/}}
{{- define "hoppscotch.getImage" -}}
{{- if .value.digest -}}
{{ .value.repository }}@{{ .value.digest }}
{{- else -}}
{{ .value.repository }}:{{ .value.tag | default .context.Chart.AppVersion }}
{{- end -}}
{{- end -}}

{{/* Format env vars */}}
{{- define "hoppscotch.extraEnv" -}}
  {{- with . -}}
    {{- $result := list -}}
    {{- range $name, $value := . -}}
        {{- if or (kindIs "float64" $value) (kindIs "bool" $value) -}}
          {{- $result = append $result (dict "name" $name "value" ($value | toString)) -}}
        {{- else -}}
          {{- $result = append $result (dict "name" $name "value" $value) -}}
        {{- end -}}
      {{- end -}}
    {{- toYaml $result | nindent 0 -}}
  {{- end -}}
{{- end -}}

{{/* Format service list */}}
{{- define "hoppscotch.getServiceList" -}}
{{- $services := list -}}
{{- if .Values.admin.enabled -}}
  {{- $services = append $services (printf "%s://%s:%d/admin" ( include "hoppscotch.getWebPrtcl" .) .Values.ingress.hostname (.Values.admin.containerPorts.server | int )) -}}
{{- end -}}
{{- if .Values.backend.enabled -}}
  {{- $services = append $services (printf "%s://%s:%d/backend" ( include "hoppscotch.getWebPrtcl" .) .Values.ingress.hostname (.Values.backend.containerPorts.server | int )) -}}
{{- end -}}
{{- if .Values.frontend.enabled -}}
  {{- $services = append $services (printf "%s://%s:%d" ( include "hoppscotch.getWebPrtcl" .) .Values.ingress.hostname (.Values.frontend.containerPorts.server | int )) -}}
{{- end -}}
{{- $serviceList := join "," $services -}}
{{ $serviceList }}
{{- end -}}
