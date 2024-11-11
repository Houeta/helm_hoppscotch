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