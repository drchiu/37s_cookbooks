name "backup"
description "Backup Server"
recipes "backup::server", "nfs::server"

default_attributes :active_groups => {:storage => {:enabled => true}}
