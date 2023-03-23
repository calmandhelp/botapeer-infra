variable "access_key" {
  description = "アクセスキー"
}
variable "secret_key" {
  description = "シークレットキー"
}
variable "account_id" {
  description = "アカウントID"
}
variable "environment" {
  default     = "prod"
  description = "環境を表す変数"
}
variable "service_name" {
  default     = "botapeer"
  description = "サービス名"
}
variable "s3_access_key" {
  description = "S3のアクセスキー"
}
variable "s3_secret_key" {
  description = "S3のシークレットキー"
}
variable "db_url" {
  description = "S3のシークレットキー"
}
variable "db_schema" {
  description = "DBスキーマ"
}
variable "datasource_url" {
  description = "データソースURL"
}
variable "db_username" {
  description = "DBユーザー名"
}
variable "db_password" {
  description = "DBパスワード"
}
variable "db_driver_classname" {
  description = "DBドライバークラス"
}
variable "region" {
  description = "リージョン"
}
variable "image_path" {
  description = "イメージパス"
}
variable "jwt_secret" {
  description = "認証基盤のシークレット"
}
variable "jwt_expiration" {
  description = "認証基盤のトークンの有効期限"
}
variable "domain_name" {
  default = "botapeer.com"
  description = "domain名"
}