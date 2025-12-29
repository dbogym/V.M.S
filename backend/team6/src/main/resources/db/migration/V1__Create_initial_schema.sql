-- code table init
CREATE TABLE code (
                      code_id    BIGINT AUTO_INCREMENT NOT NULL,
                      created_at datetime              NULL,
                      updated_at datetime              NULL,
                      group_code VARCHAR(255)          NOT NULL,
                      code       VARCHAR(255)          NOT NULL,
                      name       VARCHAR(255)          NOT NULL,
                      CONSTRAINT uc_group_code_code UNIQUE (group_code, code),
                      CONSTRAINT pk_code PRIMARY KEY (code_id)
);

-- member_info table init
CREATE TABLE member_info (
                             member_info_id BIGINT AUTO_INCREMENT NOT NULL,
                             created_at     datetime              NULL,
                             updated_at     datetime              NULL,
                             birth          VARCHAR(255)          NOT NULL,
                             email          VARCHAR(255)          NOT NULL,
                             password       VARCHAR(255)          NOT NULL,
                             CONSTRAINT pk_member_info PRIMARY KEY (member_info_id)
);

-- dept table init
CREATE TABLE dept (
                      dept_id        BIGINT AUTO_INCREMENT NOT NULL,
                      created_at     datetime              NULL,
                      updated_at     datetime              NULL,
                      dept_name      VARCHAR(255)          NOT NULL,
                      dept_leader_id BIGINT                NULL,
                      CONSTRAINT uc_dept_dept_leader UNIQUE (dept_leader_id),
                      CONSTRAINT pk_dept PRIMARY KEY (dept_id)
);

-- member table init
CREATE TABLE member (
                        member_id      BIGINT AUTO_INCREMENT NOT NULL,
                        created_at     datetime              NULL,
                        updated_at     datetime              NULL,
                        name           VARCHAR(255)          NOT NULL,
                        dept_id        BIGINT                NULL,
                        position_id    BIGINT                NULL,
                        join_date      datetime              NOT NULL,
                        `role`         VARCHAR(255)          NOT NULL,
                        member_info_id BIGINT                NULL,
                        CONSTRAINT uc_member_member_info UNIQUE (member_info_id),
                        CONSTRAINT pk_member PRIMARY KEY (member_id)
);

-- vacation_request table init
CREATE TABLE vacation_request (
                                  vacation_request_id BIGINT AUTO_INCREMENT NOT NULL,
                                  created_at          datetime              NULL,
                                  updated_at          datetime              NULL,
                                  member_id           BIGINT                NULL,
                                  from_date           datetime              NOT NULL,
                                  to_date             datetime              NOT NULL,
                                  reason              VARCHAR(255)          NULL,
                                  type_code           BIGINT                NULL,
                                  status              VARCHAR(255)          NULL,
                                  version             INT                   NULL,
                                  CONSTRAINT pk_vacation_request PRIMARY KEY (vacation_request_id)
);

-- approval_step table init
CREATE TABLE approval_step (
                               approval_step_id    BIGINT AUTO_INCREMENT NOT NULL,
                               created_at          datetime              NULL,
                               updated_at          datetime              NULL,
                               member_id           BIGINT                NOT NULL,
                               vacation_request_id BIGINT                NOT NULL,
                               approval_status     VARCHAR(255)          NOT NULL,
                               step                INT                   NOT NULL,
                               reason              VARCHAR(255)          NULL,
                               CONSTRAINT pk_approvalstep PRIMARY KEY (approval_step_id)
);

-- vacation_info table init
CREATE TABLE vacation_info (
                               vacation_id    INT AUTO_INCREMENT NOT NULL,
                               created_at     datetime           NULL,
                               updated_at     datetime           NULL,
                               total_count    DOUBLE             NOT NULL,
                               use_count      DOUBLE             NOT NULL,
                               vacation_type  VARCHAR(255)       NULL,
                               member_id      BIGINT             NULL,
                               version        INT                NOT NULL,
                               CONSTRAINT pk_vacationinfo PRIMARY KEY (vacation_id)
);

-- vacation_info_log table init
CREATE TABLE vacation_info_log (
                                   id             BIGINT AUTO_INCREMENT NOT NULL,
                                   total_count    DOUBLE                NOT NULL,
                                   use_count      DOUBLE                NOT NULL,
                                   vacation_type  VARCHAR(255)          NULL,
                                   member_id      BIGINT                NULL,
                                   log_date       datetime              NULL,
                                   CONSTRAINT pk_vacationinfolog PRIMARY KEY (id)
);

-- Foreign Key 제약조건들
ALTER TABLE dept
    ADD CONSTRAINT FK_DEPT_ON_DEPT_LEADER FOREIGN KEY (dept_leader_id) REFERENCES member (member_id);

ALTER TABLE member
    ADD CONSTRAINT FK_MEMBER_ON_DEPT FOREIGN KEY (dept_id) REFERENCES dept (dept_id);

ALTER TABLE member
    ADD CONSTRAINT FK_MEMBER_ON_MEMBER_INFO FOREIGN KEY (member_info_id) REFERENCES member_info (member_info_id);

ALTER TABLE member
    ADD CONSTRAINT FK_MEMBER_ON_POSITION FOREIGN KEY (position_id) REFERENCES code (code_id);

ALTER TABLE vacation_request
    ADD CONSTRAINT FK_VACATION_REQUEST_ON_MEMBER FOREIGN KEY (member_id) REFERENCES member (member_id);

ALTER TABLE vacation_request
    ADD CONSTRAINT FK_VACATION_REQUEST_ON_TYPE_CODE FOREIGN KEY (type_code) REFERENCES code (code_id);

ALTER TABLE approval_step
    ADD CONSTRAINT FK_APPROVALSTEP_ON_MEMBER FOREIGN KEY (member_id) REFERENCES member (member_id);

ALTER TABLE approval_step
    ADD CONSTRAINT FK_APPROVALSTEP_ON_VACATION_REQUEST FOREIGN KEY (vacation_request_id) REFERENCES vacation_request (vacation_request_id);