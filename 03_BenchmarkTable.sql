CREATE TABLE index_benchmarks (
    test_id SERIAL PRIMARY KEY,
    test_name TEXT,
    index_type TEXT,
    query TEXT,
    avg_time_ms NUMERIC(10,3),
    plan_summary TEXT
);
