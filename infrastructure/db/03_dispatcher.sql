CREATE TABLE IF NOT EXISTS dispatch_alerts (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    listing_id BIGINT NOT NULL,
    ngo_id BIGINT NOT NULL,
    channel VARCHAR(20) NOT NULL CHECK (channel IN ('SMS', 'EMAIL')),
    status VARCHAR(20) NOT NULL CHECK (status IN ('SENT', 'FAILED', 'FALLBACK_SENT')),
    sent_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX IF NOT EXISTS idx_listing_ngo ON dispatch_alerts (listing_id, ngo_id);