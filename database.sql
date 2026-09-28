CREATE TABLE IF NOT EXISTS gun_textures (
    id INT AUTO_INCREMENT PRIMARY KEY,
    weapon_name VARCHAR(255) NOT NULL,
    texture_name VARCHAR(255) NOT NULL
);

-- Insert default textures
INSERT INTO gun_textures (weapon_name, texture_name) VALUES
    ('WEAPON_PISTOL', 'pistol_texture'),
    ('WEAPON_ASSAULTRIFLE', 'assault_rifle_texture');