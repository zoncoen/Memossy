CREATE TABLE page (
    id int(10) unsigned NOT NULL auto_increment,
    rid varchar(255) binary NOT NULL,
    title varchar(255) NOT NULL,
    body text NOT NULL,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE KEY rid (rid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;