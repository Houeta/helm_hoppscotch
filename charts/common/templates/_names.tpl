{{/* vim set filetype=mustache: */}}

{{/*
Expand the name of the chart
*/}}
{{- define "common.names.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label
*/}}
{{- define "common.names.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fulle qualified app name.
If release name contains chart name it will be used as a full name
*/}}
{{- define "common.names.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc63 | trimsuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc63 | trimsuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc63 | trimsuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}