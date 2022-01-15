{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "yzbfp.name" -}}
{{- include "common.names.name" . -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "yzbfp.fullname" -}}
{{- include "common.names.fullname" . -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "yzbfp.nacos.fullname" -}}
{{- printf "%s-%s" .Release.Name "nacos" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "yzbfp.redis.fullname" -}}
{{- printf "%s-%s" .Release.Name "redis" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "yzbfp.mongodb.fullname" -}}
{{- printf "%s-%s" .Release.Name "mongodb" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "yzbfp.chart" -}}
{{- include "common.names.chart" . -}}
{{- end -}}

{{/*
Return the proper YZBFP image name
*/}}
{{- define "yzbfp.image" -}}
{{ include "common.images.image" (dict "imageRoot" .Values.image "global" .Values.global) }}
{{- end -}}

{{/*
Return the proper Docker Image Registry Secret Names
*/}}
{{- define "yzbfp.imagePullSecrets" -}}
{{ include "common.images.pullSecrets" (dict "images" (list .Values.image) "global" .Values.global) }}
{{- end -}}

{{/*
Return  the proper Storage Class
*/}}
{{- define "yzbfp.storageClass" -}}
{{- include "common.storage.class" (dict "persistence" .Values.persistence "global" .Values.global) -}}
{{- end -}}

{{/*
Return the MySql hostname
*/}}
{{- define "yzbfp.databaseHost" -}}
{{- if .Values.mysql.enabled }}
    {{- printf "%s" (include "yzbfp.mysql.fullname" .) -}}
{{- else -}}
    {{- printf "%s" .Values.externalDatabase.host -}}
{{- end -}}
{{- end -}}

{{/*
Return the MySql port
*/}}
{{- define "yzbfp.databasePort" -}}
{{- if .Values.mysql.enabled }}
    {{- printf "3306" | quote -}}
{{- else -}}
    {{- .Values.externalDatabase.port | quote -}}
{{- end -}}
{{- end -}}

{{/*
Return the MySql database name
*/}}
{{- define "yzbfp.databaseName" -}}
{{- if .Values.mysql.enabled }}
    {{- printf "%s" .Values.mysql.mysqlDatabase -}}
{{- else -}}
    {{- printf "%s" .Values.externalDatabase.database -}}
{{- end -}}
{{- end -}}

{{/*
Return the MySql user
*/}}
{{- define "yzbfp.databaseUser" -}}
{{- if .Values.mysql.enabled }}
    {{- printf "%s" .Values.mysql.mysqlUsername -}}
{{- else -}}
    {{- printf "%s" .Values.externalDatabase.user -}}
{{- end -}}
{{- end -}}

{{/*
Return the MySql Secret Name
*/}}
{{- define "yzbfp.databaseSecretName" -}}
{{- if .Values.mysql.enabled }}
    {{- if .Values.mysql.existingSecret }}
        {{- printf "%s" .Values.mysql.existingSecret -}}
    {{- else -}}
        {{- printf "%s" (include "yzbfp.mysql.fullname" .) -}}
    {{- end -}}
{{- else if .Values.externalDatabase.existingSecret }}
    {{- printf "%s" .Values.externalDatabase.existingSecret -}}
{{- else -}}
    {{- printf "%s-%s" .Release.Name "externaldb" -}}
{{- end -}}
{{- end -}}

{{/*
Return the Redis hostname
*/}}
{{- define "yzbfp.redisHost" -}}
{{- if .Values.redis.enabled }}
    {{- printf "%s-%s" (include "yzbfp.redis.fullname" .) "master" -}}
{{- else -}}
    {{- printf "%s-%s" .Release.Name "master" -}}
{{- end -}}
{{- end -}}

{{/*
Return the Redis port
*/}}
{{- define "yzbfp.redisPort" -}}
{{- if .Values.redis.enabled }}
    {{- printf "6379" | quote -}}
{{- else -}}
    {{- printf "6379" | quote -}}
{{- end -}}
{{- end -}}

{{/*
Return the Redis Secret Name
*/}}
{{- define "yzbfp.redisSecretName" -}}
{{- if .Values.redis.enabled }}
    {{- printf "%s" (include "yzbfp.redis.fullname" .) -}}
{{- else -}}
    {{- printf "%s-%s" .Release.Name "redis" -}}
{{- end -}}
{{- end -}}

{{/*
YZBfp credential secret name
*/}}
{{- define "yzbfp.secretName" -}}
{{- coalesce .Values.existingSecret (include "yzbfp.fullname" .) -}}
{{- end -}}


{{/*
 Create the name of the service account to use
 */}}
{{- define "yzbfp.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
    {{ default (include "yzbfp.fullname" .) .Values.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccount.name }}
{{- end -}}
{{- end -}}
