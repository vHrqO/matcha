CREATE TABLE Session (
    id INTEGER PRIMARY KEY,
    position INTEGER NOT NULL UNIQUE,

    name TEXT NOT NULL
);

CREATE TABLE TabsItem (
    id INTEGER PRIMARY KEY,
    sessionId INTEGER NOT NULL,
    position INTEGER NOT NULL,

    isGroup BOOLEAN NOT NULL DEFAULT false,
    tabsItemType TEXT NOT NULL,

    title TEXT NOT NULL,

    FOREIGN KEY (sessionId) REFERENCES Session(id) ON DELETE CASCADE,
    CHECK (tabsItemType IN ('app', 'browser')),
    UNIQUE (sessionId, position)
);

CREATE TABLE TabGroup (
    id INTEGER PRIMARY KEY,

    FOREIGN KEY (id) REFERENCES TabsItem(id) ON DELETE CASCADE
);

CREATE TABLE Tab (
    id INTEGER PRIMARY KEY,
    groupId INTEGER,
    position INTEGER,

    url TEXT NOT NULL,

    FOREIGN KEY (id) REFERENCES TabsItem(id) ON DELETE CASCADE,
    FOREIGN KEY (groupId) REFERENCES TabGroup(id) ON DELETE CASCADE,

    UNIQUE (groupId, position),
    CHECK (
        -- If in group, must have position
        -- If not in group, position must be NULL
        (groupId IS NULL) = (position IS NULL)
    )
);

CREATE TABLE TabsItemTag (
    id INTEGER PRIMARY KEY,
    tabsItemId INTEGER NOT NULL,

    tag TEXT NOT NULL,
    
    FOREIGN KEY (tabsItemId) REFERENCES TabsItem(id) ON DELETE CASCADE,
    UNIQUE (tabsItemId, tag)
);