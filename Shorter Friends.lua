local f = CreateFrame("Frame")
local originalWidth = 150
local initialized = false
 
function f:OnEvent(event, addOnName)
	EnableShortFrames = EnableShortFrames or true
	FrameWidth = FrameWidth or originalWidth
	if event == "NAME_PLATE_UNIT_ADDED" and initialized == false then
	    UpdateShortPlates()
	    initialized=true
	elseif addOnName == "Shorter Friends" then
	    if EnableShortFrames then
            print("\124cff00ccffNameplates Shortened :)\124r")
        end
        EnableShortFrames = EnableShortFrames
		self:InitializeOptions()
	end
end
 
function ToggleShortPlates()
	EnableShortFrames = not EnableShortFrames
    if EnableShortFrames then
        C_NamePlate.SetNamePlateFriendlySize(FrameWidth,100)
    else
        C_NamePlate.SetNamePlateFriendlySize(originalWidth,100)
    end
end
 
function UpdateShortPlates()
    if EnableShortFrames then
        C_NamePlate.SetNamePlateFriendlySize(FrameWidth,100)
    end
end
 
f:RegisterEvent("ADDON_LOADED")
f:RegisterEvent("NAME_PLATE_UNIT_ADDED")
f:SetScript("OnEvent", f.OnEvent)
 
function f:InitializeOptions()
	--Main Panel
	self.panel = CreateFrame("Frame")
	self.panel.name = "Shorter Friends"
 
    --Title
    local title = self.panel:CreateFontString("ARTWORK", nil, "GameFontNormalLarge")
    title:SetPoint("TOPLEFT", 10, -20)
    title:SetText("Shorter Friends")
	title:SetFont("Fonts\\FRIZQT__.TTF", 22)
 
    --Enabling Button
	local cb = CreateFrame("CheckButton", nil, self.panel, "InterfaceOptionsCheckButtonTemplate")
	cb:SetPoint("TOPLEFT", 10, -50)
    cb:SetSize(40,40)
	cb.Text:SetText("Enable shorter friendly nameplates")
	cb.Text:SetTextColor(1,1,1,1);
	cb.Text:SetFont("Fonts\\FRIZQT__.TTF", 16)
 
	cb:SetChecked(EnableShortFrames) -- set the initial checked state
    cb:SetScript("OnClick", function() -- update button state
        ToggleShortPlates()
    end)
 
	--WidthSlider
	local widthSlider = CreateFrame("Slider", "WidthSlider", self.panel, "OptionsSliderTemplate")
	widthSlider:SetPoint("TOPLEFT", 15, -120)
	widthSlider:SetWidth(150)
	widthSlider:SetHeight(15)
 
	widthSlider:SetObeyStepOnDrag(true)
	widthSlider:SetMinMaxValues(50,250)
	widthSlider:SetValueStep(1)
	widthSlider:SetValue(FrameWidth or 150)
 
	widthSlider.Text:SetText("Frame width")
	widthSlider.Text:SetTextColor(1,1,1,1);
	widthSlider.Text:SetFont("Fonts\\FRIZQT__.TTF", 16)
 
	widthSlider:SetScript("OnValueChanged", function()
		widthText:SetText(FrameWidth)
		FrameWidth = widthSlider:GetValue()
		UpdateShortPlates()
	end)
 
	--Width Text
	widthText = widthSlider:CreateFontString("ARTWORK", nil, "GameFontNormalLarge")
	widthText:SetPoint("CENTER", 0, -15)
	widthText:SetText(FrameWidth)
	widthText:SetFont("Fonts\\FRIZQT__.TTF", 16)
 
	--ResetButton
	local resetButton = CreateFrame("Button", "Reset Width", widthSlider, "UIPanelButtonTemplate")
	resetButton:SetPoint("RIGHT", 95, 0)
	resetButton:SetSize(75,25)
	resetButton:SetText("Reset Width")
	resetButton.Text:SetFont("Fonts\\FRIZQT__.TTF", 10)
	resetButton:SetScript("OnClick", function()
		widthSlider:SetValue(originalWidth)
		widthText:SetText(originalWidth)
		UpdateShortPlates()
	end)
 
	InterfaceOptions_AddCategory(self.panel)
end
 
SLASH_SHORTER1 = "/SF"
SlashCmdList.SHORTER = function()
	InterfaceOptionsFrame_OpenToCategory(f.panel)
end
 
SLASH_RELOAD1 = "/RL"
SlashCmdList.RELOAD = function()
	ReloadUI()
end
 
