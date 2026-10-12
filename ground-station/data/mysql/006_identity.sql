USE satellite_ground;

CREATE TABLE users (
 user_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 username VARCHAR(128) NOT NULL UNIQUE,
 email VARCHAR(320) NOT NULL UNIQUE,
 password_hash VARCHAR(255) NOT NULL,
 display_name VARCHAR(128) NOT NULL,
 status VARCHAR(32) NOT NULL DEFAULT 'ACTIVE',
 created_at TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
 last_login_at TIMESTAMP(6)
);

CREATE TABLE roles (
 role_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 role_name VARCHAR(32) NOT NULL UNIQUE,
 description VARCHAR(255) NOT NULL
);

CREATE TABLE user_roles (
 user_id BIGINT UNSIGNED NOT NULL,
 role_id BIGINT UNSIGNED NOT NULL,
 PRIMARY KEY(user_id, role_id),
 FOREIGN KEY(user_id) REFERENCES users(user_id),
 FOREIGN KEY(role_id) REFERENCES roles(role_id)
);

CREATE TABLE sessions (
 session_id CHAR(64) PRIMARY KEY,
 user_id BIGINT UNSIGNED NOT NULL,
 issued_at TIMESTAMP(6) NOT NULL,
 expires_at TIMESTAMP(6) NOT NULL,
 revoked_at TIMESTAMP(6),
 ip_address VARCHAR(64),
 user_agent VARCHAR(512),
 FOREIGN KEY(user_id) REFERENCES users(user_id),
 KEY ix_session_user (user_id, expires_at)
);

CREATE TABLE audit_log (
 audit_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 user_id BIGINT UNSIGNED,
 action VARCHAR(128) NOT NULL,
 resource_type VARCHAR(64),
 resource_id VARCHAR(128),
 result VARCHAR(32) NOT NULL,
 details TEXT,
 created_at TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
 FOREIGN KEY(user_id) REFERENCES users(user_id),
 KEY ix_audit_time (created_at)
);

INSERT INTO roles(role_name,description) VALUES
 ('ADMIN','System and user administration'),
 ('OPERATOR','Telemetry, media and approved command operations'),
 ('ANALYST','Read-only data analysis'),
 ('VIEWER','Read-only dashboards')
ON DUPLICATE KEY UPDATE description=VALUES(description);
