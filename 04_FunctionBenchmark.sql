CREATE OR REPLACE FUNCTION run_benchmark(
    test_name TEXT,
    index_type TEXT,
    query TEXT
)
RETURNS VOID AS $$
DECLARE
    result JSON;
    runtime_ms NUMERIC;
BEGIN
    EXECUTE format('EXPLAIN (ANALYZE, FORMAT JSON) %s', query) INTO result;
    runtime_ms := (result->0->'Execution Time')::text::numeric;
    INSERT INTO index_benchmarks(test_name, index_type, query, avg_time_ms, plan_summary)
    VALUES (test_name, index_type, query, runtime_ms,
            result->0->'Plan'->>'Node Type');
END;
$$ LANGUAGE plpgsql;
