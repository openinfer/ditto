{{/* vim: set filetype=mustache: */}}

{{/*
Create a name with appid details
*/}}
{{- define "mongo-connector.appname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else -}}
{{- printf "mdb-%s" .Values.appId | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "mongo-connector.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels Mongo Connector
*/}}
{{- define "mongo-connector.labels" -}}
app.ditto.live/service-group: "hydra"
app.ditto.live/exposed: "true"
app.ditto.live/repo: "ditto"
app.ditto.live/tier: "app"
app.ditto.live/runtime: "rust"
app.kubernetes.io/part-of: "{{ .Chart.Name }}"
app.kubernetes.io/component: "mongo-connector"
helm.sh/chart: {{ include "mongo-connector.chart" . }}
hades.app.ditto.live/target-cluster: {{ tpl $.Values.hydraCluster.name . }}
{{- if .Values.additionalLabels }}
{{ toYaml .Values.additionalLabels }}
{{- end }}
app.kubernetes.io/name: {{ include "mongo-connector.appname" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}
