SELECT test_id, test_name, index_type, avg_time_ms, plan_summary
FROM index_benchmarks
ORDER BY avg_time_ms ASC;
