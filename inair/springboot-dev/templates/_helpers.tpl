{{/* vim: set filetype=mustache: */}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "sb.postgresql.fullname" -}}
{{- include "common.names.dependency.fullname" (dict "chartName" "postgresql" "chartValues" .Values.postgresql "context" $) -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "sb.redis.fullname" -}}
{{- include "common.names.dependency.fullname" (dict "chartName" "redis" "chartValues" .Values.redis "context" $) -}}
{{- end -}}

{{/*
Return the proper Odoo image name
*/}}
{{- define "sb.image" -}}
{{ include "common.images.image" (dict "imageRoot" .Values.image "global" .Values.global) }}
{{- end -}}

{{/*
Return the proper Docker Image Registry Secret Names
*/}}
{{- define "sb.imagePullSecrets" -}}
{{ include "common.images.pullSecrets" (dict "images" (list .Values.image) "global" .Values.global) }}
{{- end -}}

{{/*
Return the Postgresql hostname
*/}}
{{- define "sb.databaseHost" -}}
{{- if .Values.postgresql.enabled }}
    {{- (include "sb.postgresql.fullname" .) -}}
{{- else -}}
    {{- .Values.externalDatabase.host -}}
{{- end -}}
{{- end -}}

{{/*
Return the Postgresql port
*/}}
{{- define "sb.databasePort" -}}
{{- if .Values.postgresql.enabled }}
    {{- printf "5432" -}}
{{- else -}}
    {{- .Values.externalDatabase.port -}}
{{- end -}}
{{- end -}}

{{/*
Return the Postgresql database name
*/}}
{{- define "sb.databaseName" -}}
{{- if .Values.postgresql.enabled }}
    {{- if .Values.global.postgresql }}
        {{- if .Values.global.postgresql.auth }}
            {{- coalesce .Values.global.postgresql.auth.database .Values.postgresql.auth.database -}}
        {{- else -}}
            {{- .Values.postgresql.auth.database -}}
        {{- end -}}
    {{- else -}}
        {{- .Values.postgresql.auth.database -}}
    {{- end -}}
{{- else -}}
    {{- .Values.externalDatabase.database -}}
{{- end -}}
{{- end -}}

{{/*
Return the Postgresql user
*/}}
{{- define "sb.databaseUser" -}}
{{- if .Values.postgresql.enabled }}
    {{- if .Values.global.postgresql }}
        {{- if .Values.global.postgresql.auth }}
            {{- coalesce .Values.global.postgresql.auth.username .Values.postgresql.auth.username -}}
        {{- else -}}
            {{- .Values.postgresql.auth.username -}}
        {{- end -}}
    {{- else -}}
        {{- .Values.postgresql.auth.username -}}
    {{- end -}}
{{- else -}}
    {{- .Values.externalDatabase.user -}}
{{- end -}}
{{- end -}}

{{/*
Return the Postgresql user password
*/}}
{{- define "sb.databasePassword" -}}
{{- if .Values.postgresql.enabled }}
    {{- .Values.postgresql.auth.password -}}
{{- else -}}
    {{- printf "%s" .Values.externalDatabase.password -}}
{{- end -}}
{{- end -}}

{{/*
Return the Redis hostname
*/}}
{{- define "sb.redisHost" -}}
{{- default (printf "%s-master" (include "sb.redis.fullname" .)) -}}
{{- end -}}

{{/*
Return the Redis port
*/}}
{{- define "sb.redisPort" -}}
{{- printf "6379" -}}
{{- end -}}

{{/*
Return the Redis user password
*/}}
{{- define "sb.redisPassword" -}}
{{- if .Values.redis.enabled }}
    {{- printf "%s" .Values.redis.auth.password -}}
{{- else -}}
    {{- printf "123" -}}
{{- end -}}
{{- end -}}

{{/*
Odoo credential secret name
*/}}
{{- define "sb.secretName" -}}
{{- coalesce .Values.existingSecret (include "common.names.fullname" .) -}}
{{- end -}}

{{/*
Return the SMTP Secret Name
*/}}
{{- define "sb.smtpSecretName" -}}
{{- coalesce .Values.smtpExistingSecret (include "common.names.fullname" .) -}}
{{- end -}}

{{/*
 Create the name of the service account to use
 */}}
{{- define "sb.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
    {{ default (include "common.names.fullname" .) .Values.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccount.name }}
{{- end -}}
{{- end -}}
