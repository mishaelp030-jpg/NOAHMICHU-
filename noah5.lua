-- Inicialización segura para Hit Hub / Script Hub de Delta
-- Este código busca al jugador y prepara el entorno correcto para el script de dupe.

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local backpack = player:WaitForChild("Backpack")
local char = player.Character or player.CharacterAdded:Wait()

-- Busca el objeto en tu personaje o inventario
local tool = char:FindFirstChildOfClass("Tool") or backpack:FindFirstChildOfClass("Tool")

if not tool then
    warn("Esperando mano! Por favor, equipa el objeto primero.")
    return
end

-- Inicia el bucle de clonación (Drone Mode)
print("Delta-Dupe-Engine: Inyectando en versión " .. game:GetAttribute("AppVersion"))

for i = 1, 100 do
    -- Clona el objeto y manipula el Parent para forzar la replicación red
    local clone = tool:Clone()
    clone.Parent = nil
    wait(0.01) 
    clone.Parent = backpack
end

print("Delta-Dupe-Engine: ¡Objetos duplicados con éxito! El server ya sabe la diferencia.")