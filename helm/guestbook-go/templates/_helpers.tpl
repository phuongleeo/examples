{{/*
Expand the name of the Guestbook chart.
*/}}
{{- define "guestbook-go.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "guestbook-go.fullname" -}}
{{- if .Values.guestbook.fullnameOverride }}
{{- .Values.guestbook.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.guestbook.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "guestbook-go.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "guestbook-go.labels" -}}
helm.sh/chart: {{ include "guestbook-go.chart" . }}
{{ include "guestbook-go.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "guestbook-go.selectorLabels" -}}
app.kubernetes.io/name: {{ include "guestbook-go.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app: {{ include "guestbook-go.name" . -}}
{{- range $key, $value := .Values.labels }}
{{ $key }}: {{ $value | quote }}
{{- end -}}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "guestbook-go.serviceAccountName" -}}
{{- default (include "guestbook-go.fullname" .) .Values.guestbook.serviceAccount.name }}
{{- end }}

{{/*
Expand the name of the REDIS chart.
*/}}

{{- define "redis.fullname" -}}
{{- if .Values.redis.fullnameOverride }}
{{- .Values.redis.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.redis.fullnameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s-redis" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end -}}
{{- end -}}
{{- end -}}

{{- define "redis.name" -}}
  {{- printf "%s" (include "redis.fullname" .) -}}
{{- end -}}