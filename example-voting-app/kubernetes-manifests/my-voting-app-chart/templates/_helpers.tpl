{{/*
Expand the name of the chart.
*/}}
{{- define "my-voting-app.name" -}}
{{- default .Chart.Name .Values.name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes names are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "my-voting-app.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.name }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as a chart label.
*/}}
{{- define "my-voting-app.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "my-voting-app.labels" -}}
helm.sh/chart: {{ include "my-voting-app.chart" . }}
{{ include "my-voting-app.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "my-voting-app.selectorLabels" -}}
app.kubernetes.io/name: {{ include "my-voting-app.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Full image name for vote service
*/}}
{{- define "my-voting-app.voteImage" -}}
{{- printf "%s/example-voting-app-vote:%s" .Values.image.repository .Values.image.tag -}}
{{- end }}

{{/*
Full image name for result service
*/}}
{{- define "my-voting-app.resultImage" -}}
{{- printf "%s/example-voting-app-result:%s" .Values.image.repository .Values.image.tag -}}
{{- end }}

{{/*
Full image name for worker service
*/}}
{{- define "my-voting-app.workerImage" -}}
{{- printf "%s/example-voting-app-worker:%s" .Values.image.repository .Values.image.tag -}}
{{- end }}

{{/*
Full image name for seedData service
*/}}
{{- define "my-voting-app.seedDataImage" -}}
{{- printf "%s/example-voting-app-seed-data:%s" .Values.seedData.image.repository .Values.seedData.image.tag -}}
{{- end }}
