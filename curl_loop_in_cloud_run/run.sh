#!/bin/ash

# 您的迴圈函式
run_curl_loop() {
    # 確保 $URI 和 $SEC 變數可用
    sleep 5
    while true; do
        DATE=$(date)
        TIME_TOTAL=$(curl -w "time_total:  %{time_total}\n" -o /dev/null -s "$URI")
        echo "[ $DATE ] = = = = $TIME_TOTAL"
        sleep $SEC
    done
}

# 1. 執行迴圈 (在背景)
# 它的 stdout (date/curl) 會正常輸出到 Standard Output
run_curl_loop &

# 2. 執行 Nginx (在前台)，並將其所有輸出都丟棄
echo "Starting Nginx in foreground (outputs suppressed)..."
nginx -g 'daemon off;' > /dev/null 2>&1
