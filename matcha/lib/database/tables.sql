CREATE TABLE session (
    id INTEGER PRIMARY KEY,
    position INTEGER NOT NULL UNIQUE,

    name TEXT NOT NULL
);

CREATE TABLE tabs_item (
    id INTEGER PRIMARY KEY,
    session_id INTEGER NOT NULL,
    position INTEGER NOT NULL,

    is_group BOOLEAN NOT NULL DEFAULT FALSE,
    title TEXT NOT NULL,

    FOREIGN KEY (session_id) REFERENCES session(id) ON DELETE CASCADE,
    UNIQUE (session_id, position)
);

CREATE TABLE tab_group (
    id INTEGER PRIMARY KEY,

    FOREIGN KEY (id) REFERENCES tabs_item(id) ON DELETE CASCADE
);

CREATE TABLE tab (
    id INTEGER PRIMARY KEY,
    group_id INTEGER,
    position INTEGER,

    url TEXT NOT NULL,

    FOREIGN KEY (id) REFERENCES tabs_item(id) ON DELETE CASCADE,
    FOREIGN KEY (group_id) REFERENCES tab_group(id) ON DELETE CASCADE,

    UNIQUE (group_id, position),
    CHECK (
        -- If in group, must have position
        -- If not in group, position must be NULL
        (group_id IS NULL) = (position IS NULL)
    )
);

CREATE TABLE tabs_item_tag (
    id INTEGER PRIMARY KEY,
    tabs_item_id INTEGER NOT NULL,

    tag TEXT NOT NULL,
    
    FOREIGN KEY (tabs_item_id) REFERENCES tabs_item(id) ON DELETE CASCADE,
    UNIQUE (tabs_item_id, tag)
);
