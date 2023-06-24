{{/*
Expand the name of the chart.
*/}}
{{- define "backstagehelm.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "backstagehelm.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "backstagehelm.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common App labels
*/}}
{{- define "backstagehelm.app.labels" -}}
app.kubernetes.io/name: {{ include "backstagehelm.name" . }}-app
helm.sh/chart: {{ include "backstagehelm.chart" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Common Backend labels
*/}}
{{- define "backstagehelm.backend.labels" -}}
app.kubernetes.io/name: {{ include "backstagehelm.name" . }}-backend
helm.sh/chart: {{ include "backstagehelm.chart" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Create the name of the service account to use for the app
*/}}
{{- define "backstagehelm.app.serviceAccountName" -}}
{{- if .Values.app.serviceAccount.create -}}
    {{ default "default" .Values.app.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.app.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Create the name of the service account to use for the backend
*/}}
{{- define "backstagehelm.backend.serviceAccountName" -}}
{{- if .Values.backend.serviceAccount.create -}}
    {{ default default .Values.backend.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.backend.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Name of the backend service
*/}}
{{- define "backend.serviceName" -}}
{{ include "backstagehelm.fullname" . }}-backend
{{- end -}}

{{/*
Name of the frontend service
*/}}
{{- define "frontend.serviceName" -}}
{{ include "backstagehelm.fullname" . }}-frontend
{{- end -}}


{{/*
app-config file name
*/}}
{{- define "backstagehelm.appConfigFilename" -}}
{{- "app-config.yaml" -}}
{{- end -}}