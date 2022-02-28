{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "fengyue.name" -}}
{{- include "common.names.name" . -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "fengyue.fullname" -}}
{{- include "common.names.fullname" . -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "fengyue.fullname.order" -}}
{{- printf "%s-order" (include "common.names.fullname" .) -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "fengyue.fullname.mall" -}}
{{- printf "%s-mall" (include "common.names.fullname" .) -}}
{{- end -}}

{{/* vim: set filetype=mustache: */}}
{{/*
Kubernetes standard labels
*/}}
{{- define "fengyue.labels.standard.mall" -}}
app.kubernetes.io/name: {{ include "fengyue.fullname.mall" . }}
helm.sh/chart: {{ include "common.names.chart" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/* vim: set filetype=mustache: */}}
{{/*
Kubernetes standard labels
*/}}
{{- define "fengyue.labels.standard.order" -}}
app.kubernetes.io/name: {{ include "fengyue.fullname.order" . }}
helm.sh/chart: {{ include "common.names.chart" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Labels to use on deploy.spec.selector.matchLabels and svc.spec.selector
*/}}
{{- define "fengyue.labels.matchLabels.mall" -}}
app.kubernetes.io/name: {{ include "fengyue.fullname.mall" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/*
Labels to use on deploy.spec.selector.matchLabels and svc.spec.selector
*/}}
{{- define "fengyue.labels.matchLabels.order" -}}
app.kubernetes.io/name: {{ include "fengyue.fullname.order" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "fengyue.nacos.fullname" -}}
{{- printf "%s-%s" .Release.Name "nacos" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "fengyue.redis.fullname" -}}
{{- printf "%s-%s" .Release.Name "redis" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "fengyue.mongodb.fullname" -}}
{{- printf "%s-%s" .Release.Name "mongodb" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "fengyue.rabbitmq.fullname" -}}
{{- printf "%s-%s" .Release.Name "mq" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "fengyue.chart" -}}
{{- include "common.names.chart" . -}}
{{- end -}}

{{/*
Return the proper Fengyue git image name
*/}}
{{- define "fengyue.cloneStaticSiteFromGit.image" -}}
{{ include "common.images.image" (dict "imageRoot" .Values.cloneStaticSiteFromGit.image "global" .Values.global) }}
{{- end -}}

{{/*
Return the proper Fengyue image name
*/}}
{{- define "fengyue.image" -}}
{{ include "common.images.image" (dict "imageRoot" .Values.image "global" .Values.global) }}
{{- end -}}

{{/*
Return the proper Docker Image Registry Secret Names
*/}}
{{- define "fengyue.imagePullSecrets" -}}
{{ include "common.images.pullSecrets" (dict "images" (list .Values.image) "global" .Values.global) }}
{{- end -}}

{{/*
Return  the proper Storage Class
*/}}
{{- define "fengyue.storageClass" -}}
{{- include "common.storage.class" (dict "persistence" .Values.persistence "global" .Values.global) -}}
{{- end -}}

{{/*
Return the MySql hostname
*/}}
{{- define "fengyue.databaseHost" -}}
{{- if .Values.mysql.enabled }}
    {{- printf "%s" (include "fengyue.mysql.fullname" .) -}}
{{- else -}}
    {{- printf "%s" .Values.externalDatabase.host -}}
{{- end -}}
{{- end -}}

{{/*
Return the MySql port
*/}}
{{- define "fengyue.databasePort" -}}
{{- if .Values.mysql.enabled }}
    {{- printf "3306" | quote -}}
{{- else -}}
    {{- .Values.externalDatabase.port | quote -}}
{{- end -}}
{{- end -}}

{{/*
Return the MySql database name
*/}}
{{- define "fengyue.databaseName" -}}
{{- if .Values.mysql.enabled }}
    {{- printf "%s" .Values.mysql.mysqlDatabase -}}
{{- else -}}
    {{- printf "%s" .Values.externalDatabase.database -}}
{{- end -}}
{{- end -}}

{{/*
Return the MySql user
*/}}
{{- define "fengyue.databaseUser" -}}
{{- if .Values.mysql.enabled }}
    {{- printf "%s" .Values.mysql.mysqlUsername -}}
{{- else -}}
    {{- printf "%s" .Values.externalDatabase.user -}}
{{- end -}}
{{- end -}}

{{/*
Return the MySql Secret Name
*/}}
{{- define "fengyue.databaseSecretName" -}}
{{- if .Values.mysql.enabled }}
    {{- if .Values.mysql.existingSecret }}
        {{- printf "%s" .Values.mysql.existingSecret -}}
    {{- else -}}
        {{- printf "%s" (include "fengyue.mysql.fullname" .) -}}
    {{- end -}}
{{- else if .Values.externalDatabase.existingSecret }}
    {{- printf "%s" .Values.externalDatabase.existingSecret -}}
{{- else -}}
    {{- printf "%s-%s" .Release.Name "externaldb" -}}
{{- end -}}
{{- end -}}

{{- define "fengyue.kuaidiSecretName" -}}
    {{- printf "%s-%s" .Release.Name "kuaidi" -}}
{{- end -}}

{{/*
Return the Redis hostname
*/}}
{{- define "fengyue.redisHost" -}}
{{- if .Values.redis.enabled }}
    {{- printf "%s-%s" (include "fengyue.redis.fullname" .) "master" -}}
{{- else -}}
    {{- printf "%s-redis-%s" .Release.Name "master" -}}
{{- end -}}
{{- end -}}

{{/*
Return the Redis port
*/}}
{{- define "fengyue.redisPort" -}}
{{- if .Values.redis.enabled }}
    {{- printf "6379" | quote -}}
{{- else -}}
    {{- printf "6379" | quote -}}
{{- end -}}
{{- end -}}

{{/*
Return the Redis Secret Name
*/}}
{{- define "fengyue.redisSecretName" -}}
{{- if .Values.redis.enabled }}
    {{- printf "%s" (include "fengyue.redis.fullname" .) -}}
{{- else -}}
    {{- printf "%s-%s" .Release.Name "redis" -}}
{{- end -}}
{{- end -}}

{{/*
Return the Redis Secret Name
*/}}
{{- define "fengyue.mongodbSecretName" -}}
{{- if .Values.mongodb.enabled }}
    {{- printf "%s" (include "fengyue.mongodb.fullname" .) -}}
{{- else -}}
    {{- printf "%s-%s" .Release.Name "mongodb" -}}
{{- end -}}
{{- end -}}

{{/*
Return the Redis Secret Name
*/}}
{{- define "fengyue.mqSecretName" -}}
{{- if .Values.rabbitmq.enabled }}
    {{- printf "%s-default-user" (include "fengyue.rabbitmq.fullname" .) -}}
{{- else -}}
    {{- printf "%s-%s" .Release.Name "mq-default-user" -}}
{{- end -}}
{{- end -}}

{{/*
Fengyue credential secret name
*/}}
{{- define "fengyue.secretName" -}}
{{- coalesce .Values.existingSecret (include "fengyue.fullname" .) -}}
{{- end -}}


{{/*
 Create the name of the service account to use
 */}}
{{- define "fengyue.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
    {{ default (include "fengyue.fullname" .) .Values.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccount.name }}
{{- end -}}
{{- end -}}
