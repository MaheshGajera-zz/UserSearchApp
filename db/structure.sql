CREATE TABLE "organizations" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255), "email" varchar(255), "phone" varchar(255), "address1" varchar(255), "address2" varchar(255), "city" varchar(255), "zip" varchar(255), "country" varchar(255), "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "schema_migrations" ("version" varchar(255) NOT NULL);
CREATE TABLE "tasks" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "title" varchar(255), "description" varchar(255), "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL, "timing" datetime, "status" boolean, "priority" varchar(255), "user_id" integer);
CREATE TABLE "users" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255), "email" varchar(255), "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL, "password_digest" varchar(255), "remember_token" varchar(255), "organization_id" integer);
CREATE INDEX "index_tasks_on_user_id" ON "tasks" ("user_id");
CREATE INDEX "index_users_on_organization_id" ON "users" ("organization_id");
CREATE INDEX "index_users_on_remember_token" ON "users" ("remember_token");
CREATE UNIQUE INDEX "unique_schema_migrations" ON "schema_migrations" ("version");
INSERT INTO schema_migrations (version) VALUES ('20121222091502');

INSERT INTO schema_migrations (version) VALUES ('20121222161832');

INSERT INTO schema_migrations (version) VALUES ('20121226065128');

INSERT INTO schema_migrations (version) VALUES ('20130101093722');

INSERT INTO schema_migrations (version) VALUES ('20130101104656');

INSERT INTO schema_migrations (version) VALUES ('20130101105045');

INSERT INTO schema_migrations (version) VALUES ('20130102084519');

INSERT INTO schema_migrations (version) VALUES ('20130103110721');

INSERT INTO schema_migrations (version) VALUES ('20130105073106');

INSERT INTO schema_migrations (version) VALUES ('20130105151544');