{{/*
Full app name.
*/}}
{{- define "database.fullname" -}}
{{- printf "%s-%s" .Release.Name "database" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Secret name for authentication to PostgreSQL.
*/}}
{{- define "database.authSecretName" -}}
{{- printf "%s-%s-%s" .Release.Name .Chart.Name "pg-credentials" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Labels
*/}}
{{- define "database.labels" -}}
helm.sh/chart: {{ .Chart.Name }}
app.kubernetes.io/name: {{ include "database.fullname" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}


{{/*
Full qualified image name with tag or digest
*/}}
{{- define "database.getImage" -}}
{{- if .Values.image.digest -}}
{{ .Values.image.repository }}@{{ .Values.image.digest }}
{{- else -}}
{{ .Values.image.repository }}:{{ .Values.image.tag | default .Chart.AppVersion}}
{{- end -}}
{{- end -}}
