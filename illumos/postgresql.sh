#!/bin/bash

PATH="/opt/local/bin:/opt/local/sbin:/usr/bin:/usr/sbin";

STATS=`echo "SELECT 'stats', numbackends, xact_commit, xact_rollback, blks_read, blks_hit, tup_returned, tup_fetched, tup_inserted, tup_updated, tup_deleted, conflicts, temp_files, temp_bytes, deadlocks, blk_read_time, blk_write_time FROM (SELECT sum(numbackends) FROM pg_stat_database) AS numbackends, (SELECT sum(xact_commit) FROM pg_stat_database) AS xact_commit, (SELECT sum(xact_rollback) FROM pg_stat_database) AS xact_rollback, (SELECT sum(blks_read) FROM pg_stat_database) AS blks_read, (SELECT sum(blks_hit) FROM pg_stat_database) AS blks_hit, (SELECT sum(tup_returned) FROM pg_stat_database) AS tup_returned, (SELECT sum(tup_fetched) FROM pg_stat_database) AS tup_fetched, (SELECT sum(tup_inserted) FROM pg_stat_database) AS tup_inserted, (SELECT sum(tup_updated) FROM pg_stat_database) AS tup_updated, (SELECT sum(tup_deleted) FROM pg_stat_database) AS tup_deleted, (SELECT sum(conflicts) FROM pg_stat_database) AS conflicts, (SELECT sum(temp_files) FROM pg_stat_database) AS temp_files, (SELECT sum(temp_bytes) FROM pg_stat_database) AS temp_bytes, (SELECT sum(deadlocks) FROM pg_stat_database) AS deadlocks, (SELECT sum(blk_read_time) FROM pg_stat_database) AS blk_read_time, (SELECT sum(blk_write_time) FROM pg_stat_database) AS blk_write_time;" | psql -U postgres | grep stats`

CONNECTIONS=`echo "SELECT 'connections', max_connections, total, active, idle FROM (SELECT setting::float AS max_connections FROM pg_settings WHERE name = 'max_connections') max_connections, (SELECT COUNT(*) AS total FROM pg_stat_activity) total, (SELECT COUNT(*) AS active FROM pg_stat_activity WHERE state='active') active, (SELECT COUNT(*) AS idle FROM pg_stat_activity WHERE state='idle') idle;" | psql -U postgres | grep connections | tail -1`

NUMBACKENDS=`echo ${STATS} | awk -F"|" '{print $2}' | cut -d " " -f 2 | awk -F"(" '{print $2}' | awk -F")" '{print $1}'`
XACT_COMMITS=`echo ${STATS} | awk -F"|" '{print $3}' | cut -d " " -f 2 | awk -F"(" '{print $2}' | awk -F")" '{print $1}'`
XACT_ROLLBACK=`echo ${STATS} | awk -F"|" '{print $4}' | cut -d " " -f 2 | awk -F"(" '{print $2}' | awk -F")" '{print $1}'`
BLKS_READ=`echo ${STATS} | awk -F"|" '{print $5}' | cut -d " " -f 2 | awk -F"(" '{print $2}' | awk -F")" '{print $1}'`
BLKS_HIT=`echo ${STATS} | awk -F"|" '{print $6}' | cut -d " " -f 2 | awk -F"(" '{print $2}' | awk -F")" '{print $1}'`
TUP_RETURNED=`echo ${STATS} | awk -F"|" '{print $7}' | cut -d " " -f 2 | awk -F"(" '{print $2}' | awk -F")" '{print $1}'`
TUP_FETCHED=`echo ${STATS} | awk -F"|" '{print $8}' | cut -d " " -f 2 | awk -F"(" '{print $2}' | awk -F")" '{print $1}'`
TUP_INSERTED=`echo ${STATS} | awk -F"|" '{print $9}' | cut -d " " -f 2 | awk -F"(" '{print $2}' | awk -F")" '{print $1}'`
TUP_UPDATED=`echo ${STATS} | awk -F"|" '{print $10}' | cut -d " " -f 2 | awk -F"(" '{print $2}' | awk -F")" '{print $1}'`
TUP_DELETED=`echo ${STATS} | awk -F"|" '{print $11}' | cut -d " " -f 2 | awk -F"(" '{print $2}' | awk -F")" '{print $1}'`
CONFLICTS=`echo ${STATS} | awk -F"|" '{print $12}' | cut -d " " -f 2 | awk -F"(" '{print $2}' | awk -F")" '{print $1}'`
TEMP_FILES=`echo ${STATS} | awk -F"|" '{print $13}' | cut -d " " -f 2 | awk -F"(" '{print $2}' | awk -F")" '{print $1}'`
TEMP_BYTES=`echo ${STATS} | awk -F"|" '{print $14}' | cut -d " " -f 2 | awk -F"(" '{print $2}' | awk -F")" '{print $1}'`
DEADLOCKS=`echo ${STATS} | awk -F"|" '{print $15}' | cut -d " " -f 2 | awk -F"(" '{print $2}' | awk -F")" '{print $1}'`
BLK_READ_TIME=`echo ${STATS} | awk -F"|" '{print $16}' | cut -d " " -f 2 | awk -F"(" '{print $2}' | awk -F")" '{print $1}'`
BLK_WRITE_TIME=`echo ${STATS} | awk -F"|" '{print $17}' | cut -d " " -f 2 | awk -F"(" '{print $2}' | awk -F")" '{print $1}'`
CONNECTIONS_MAX=`echo ${CONNECTIONS} | awk -F"|" '{print $2}' | sed -e 's/^[ \t]*//'`
CONNECTIONS_TOTAL=`echo ${CONNECTIONS} | awk -F"|" '{print $3}' | sed -e 's/^[ \t]*//'`
CONNECTIONS_ACTIVE=`echo ${CONNECTIONS} | awk -F"|" '{print $4}' | sed -e 's/^[ \t]*//'`
CONNECTIONS_IDLE=`echo ${CONNECTIONS} | awk -F"|" '{print $5}' | sed -e 's/^[ \t]*//'`

PREFIX="postgresql:0:status:"

echo -e "${PREFIX}numbackends\ti\t${NUMBACKENDS}"
echo -e "${PREFIX}xact_commits\ti\t${XACT_COMMITS}"
echo -e "${PREFIX}xact_rollback\ti\t${XACT_ROLLBACK}"
echo -e "${PREFIX}blks_read\ti\t${BLKS_READ}"
echo -e "${PREFIX}blks_hit\ti\t${BLKS_HIT}"
echo -e "${PREFIX}tup_returned\ti\t${TUP_RETURNED}"
echo -e "${PREFIX}tup_fetched\ti\t${TUP_FETCHED}"
echo -e "${PREFIX}tup_inserted\ti\t${TUP_INSERTED}"
echo -e "${PREFIX}tup_updated\ti\t${TUP_UPDATED}"
echo -e "${PREFIX}tup_deleted\ti\t${TUP_DELETED}"
echo -e "${PREFIX}conflicts\ti\t${CONFLICTS}"
echo -e "${PREFIX}temp_files\ti\t${TEMP_FILES}"
echo -e "${PREFIX}temp_bytes\ti\t${TEMP_BYTES}"
echo -e "${PREFIX}deadlocks\ti\t${DEADLOCKS}"
echo -e "${PREFIX}blk_read_time\ti\t${BLK_READ_TIME}"
echo -e "${PREFIX}blk_write_time\ti\t${BLK_WRITE_TIME}"
echo -e "${PREFIX}connections_max\ti\t${CONNECTIONS_MAX}"
echo -e "${PREFIX}connections_idle\ti\t${CONNECTIONS_IDLE}"
echo -e "${PREFIX}connections_active\ti\t${CONNECTIONS_ACTIVE}"
