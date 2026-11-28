CREATE TABLE IF NOT EXISTS surplus_listings (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    restaurant_id BIGINT NOT NULL,
    food_title VARCHAR(150) NOT NULL,
    quantity_servings INT NOT NULL CHECK (quantity_servings > 0),
    status VARCHAR(20) NOT NULL DEFAULT 'AVAILABLE'
        CHECK (status IN ('AVAILABLE', 'CLAIMED', 'COMPLETED', 'EXPIRED')),
    expires_at TIMESTAMPTZ NOT NULL,
    claimed_by_ngo_id BIGINT NULL,
    claim_expires_at TIMESTAMPTZ NULL,
    version BIGINT NOT NULL DEFAULT 0,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX IF NOT EXISTS idx_status_expires ON surplus_listings (status, expires_at);