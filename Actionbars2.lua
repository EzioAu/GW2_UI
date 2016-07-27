local BLIZZARD_HIDE_FRAMES ={
    
    MainMenuBar,
    MainMenuBarOverlayFrame,
    MainMenuBarTexture0,
    MainMenuBarTexture1,
    MainMenuBarTexture2,
    MainMenuBarTexture3,
    MainMenuBarRightEndCap,
    MainMenuBarLeftEndCap,
    ReputationWatchBar,
    HonorWatchBar,
    ArtifactWatchBar,
    MainMenuExpBar,
    ActionBarUpButton,
    ActionBarDownButton,
    MainMenuBarPageNumber,
}

local BLIZZARD_FORCE_HIDE = {
    
    ReputationWatchBar,
    HonorWatchBar,
    MainMenuExpBar,
    ArtifactWatchBar,
}
   
local BARS= {
    MainMenuBarArtFrame,
    MultiBarLeft,
    MultiBarRight,
    MultiBarBottomLeft,
    MultiBarBottomRight,
}

function gw_hideBlizzardsActionbars() 
    for k,v in pairs(BLIZZARD_HIDE_FRAMES) do
       v:Hide() 
        if v.UnregisterAllEvents~=nil then
            v:UnregisterAllEvents() 
           
        end
    end    
    for k,v in pairs(BLIZZARD_FORCE_HIDE) do
        v:SetScript('OnShow', function(self) self:Hide() end)
    end
    
end
function gw_updatehotkey(self, actionButtonType)

	local hotkey = _G[self:GetName() .. 'HotKey']
	local text = hotkey:GetText()
	
	text = string.gsub(text, '(s%-)', 'S')
	text = string.gsub(text, '(a%-)', 'A')
	text = string.gsub(text, '(c%-)', 'C')
	text = string.gsub(text, '(Mouse Button )', 'M')
	text = string.gsub(text, '(Middle Mouse)', 'M3')
	text = string.gsub(text, '(Num Pad )', 'N')
	text = string.gsub(text, '(Page Up)', 'PU')
	text = string.gsub(text, '(Page Down)', 'PD')
	text = string.gsub(text, '(Spacebar)', 'SpB')
	text = string.gsub(text, '(Insert)', 'Ins')
	text = string.gsub(text, '(Home)', 'Hm')
	text = string.gsub(text, '(Delete)', 'Del')
	text = string.gsub(text, '(Left Arrow)', 'LT')
	text = string.gsub(text, '(Right Arrow)', 'RT')
	text = string.gsub(text, '(Up Arrow)', 'UP')
	text = string.gsub(text, '(Down Arrow)', 'DN')
		
	if hotkey:GetText() == _G['RANGE_INDICATOR'] then
		hotkey:SetText('')
	else
		hotkey:SetText(text)
    end
end
    function gw_setMicroButtons()
        MicroButtonPortrait:Hide()
        GuildMicroButtonTabard:Hide()
        MainMenuBarPerformanceBar:Hide()
        TalentMicroButtonAlert:Hide()
        TalentMicroButtonAlert:SetScript('OnShow',function(self) self:Hide() end)    

        for i=1, #MICRO_BUTTONS do
        
            if  _G[MICRO_BUTTONS[i]] then    
                _G[MICRO_BUTTONS[i]]:SetScript('OnShow',function(self) self:Hide() end)    
                _G[MICRO_BUTTONS[i]]:Hide()
            end
        end
    end
  

function gw_setActionButtonStyle(buttonName, noBackDrop,hideUnused)
    if _G[buttonName..'Icon']~=nil then
        _G[buttonName..'Icon']:SetTexCoord(0.1,0.9,0.1,0.9)
    end
    if _G[buttonName.."HotKey"]~=nil then
        _G[buttonName.."HotKey"]:ClearAllPoints()
        _G[buttonName.."HotKey"]:SetPoint('CENTER',_G[buttonName],'BOTTOM',0,0)
        _G[buttonName.."HotKey"]:SetJustifyH("CENTER")
    end
    if _G[buttonName.."Count"]~=nil then
        _G[buttonName.."Count"]:ClearAllPoints()
        _G[buttonName.."Count"]:SetPoint('TOPRIGHT',_G[buttonName],'TOPRIGHT',-3,-3)
        _G[buttonName.."Count"]:SetJustifyH("RIGHT")
        _G[buttonName.."Count"]:SetFont(UNIT_NAME_FONT,14,'OUTLINED')
        _G[buttonName.."Count"]:SetTextColor(1,1,0.6)
    end
    
    if _G[buttonName..'NormalTexture']~=nil then
        _G[buttonName]:SetNormalTexture(nil)
    end 
    
    if _G[buttonName..'FloatingBG']~=nil then
        _G[buttonName..'FloatingBG']:SetTexture(nil)
    end 
    if _G[buttonName..'NormalTexture2']~=nil then
        _G[buttonName..'NormalTexture2']:SetTexture(nil)
        _G[buttonName..'NormalTexture2']:Hide()
    end
    if _G[buttonName..'AutoCastable']~=nil then
        _G[buttonName..'AutoCastable']:SetSize(_G[buttonName]:GetWidth(),_G[buttonName]:GetWidth())
    end
    
    
    _G[buttonName]:SetPushedTexture('Interface\\AddOns\\GW2_UI\\textures\\actionbutton-pressed')
    _G[buttonName]:SetHighlightTexture('Interface\\AddOns\\GW2_UI\\textures\\UI-Quickslot-Depress')
    _G[buttonName]:SetCheckedTexture('Interface\\AddOns\\GW2_UI\\textures\\UI-Quickslot-Depress')
    
    
    if noBackDrop==nil or noBackDrop==false then 
        local backDrop = CreateFrame('Frame',buttonName..'GwBackDrop',_G[buttonName]:GetParent(),'GwActionButtonBackDrop')
        backDrop:SetPoint('TOPLEFT',_G[buttonName],'TOPLEFT',-2,2)
        backDrop:SetPoint('BOTTOMRIGHT',_G[buttonName],'BOTTOMRIGHT',2,-2)
    end
    
    
    if hideUnused==true then
        _G[buttonName..'GwBackDrop']:Hide() 
        _G[buttonName]:HookScript('OnHide', function(self) 
                _G[buttonName..'GwBackDrop']:Hide() 
            end)
        _G[buttonName]:HookScript('OnShow', function(self) 
                _G[buttonName..'GwBackDrop']:Show() 
        end)
          
        
    end

    
end


function gw_setupActionbars()

   local HIDE_ACTIONBARS_CVAR = gwGetSetting('HIDEACTIONBAR_BACKGROUND_ENABLED')
    if HIDE_ACTIONBARS_CVAR then
        HIDE_ACTIONBARS_CVAR = 0 
    else
        HIDE_ACTIONBARS_CVAR = 1
    end
       
    SetCVar('alwaysShowActionBars',HIDE_ACTIONBARS_CVAR)
    

    
             
    for k,v in pairs(BARS) do
       v:SetParent(UIParent) 
    end
    
    for _, frame in pairs({
			'MultiBarLeft',
			'MultiBarRight',
			'MultiBarBottomRight',
			'MultiBarBottomLeft',

			'StanceBarFrame',
			'PossessBarFrame',

			'MULTICASTACTIONBAR_YPOS',
			'MultiCastActionBarFrame',

			'PETACTIONBAR_YPOS',
			'PETACTIONBAR_XPOS',
			
        }) do
        UIPARENT_MANAGED_FRAME_POSITIONS[frame] = nil
    end
    
    gw_updateMainBar()
    
    gw_updateCustomizableBars('MultiBarBottomRight','MultiBarBottomRightButton')
    gw_updateCustomizableBars('MultiBarBottomLeft','MultiBarBottomLeftButton')
    gw_updateCustomizableBars('MultiBarRight','MultiBarRightButton')
    gw_updateCustomizableBars('MultiBarLeft','MultiBarLeftButton')
    
    
    --gw_register_movable_frame(MultiBarBottomRight:GetName(),MultiBarBottomRight,'MultiBarBottomRight','VerticalActionBarDummy')
    --gw_register_movable_frame(MultiBarBottomLeft:GetName(),MultiBarBottomLeft,'MultiBarBottomLeft','VerticalActionBarDummy')
    gw_register_movable_frame(MultiBarRight:GetName(),MultiBarRight,'MultiBarRight','VerticalActionBarDummy')
    gw_register_movable_frame(MultiBarLeft:GetName(),MultiBarLeft,'MultiBarLeft','VerticalActionBarDummy')
    
    
    gw_hideBlizzardsActionbars() 
    gw_setMicroButtons()
    gw_setStanceBar()
    gw_setPetBar()
    gw_setbagFrame()
    gw_setLeaveVehicleButton()
    
    
    hooksecurefunc("ActionButton_UpdateHotkeys",  gw_updatehotkey)
end

function gw_updateMainBar()
    
    local MAIN_MENU_BAR_BUTTON_SIZE =50
    local MAIN_MENU_BAR_BUTTON_MARGIN = 2
    
    local USED_WIDTH = 0
    local USED_HEIGHT = MAIN_MENU_BAR_BUTTON_SIZE
    
    local BUTTON_PADDING = MAIN_MENU_BAR_BUTTON_MARGIN
    
    for i=1,12 do
        local BUTTON =  _G['ActionButton'..i]
        
        if BUTTON~=nil then
            
            BUTTON_PADDING = BUTTON_PADDING + MAIN_MENU_BAR_BUTTON_SIZE + MAIN_MENU_BAR_BUTTON_MARGIN
            
            
            gw_setActionButtonStyle('ActionButton'..i)
            gw_updatehotkey(BUTTON)
            
            _G['ActionButton'..i.."HotKey"]:SetPoint('BOTTOMLEFT',BUTTON,'BOTTOMLEFT',0,-10)
            _G['ActionButton'..i.."HotKey"]:SetPoint('BOTTOMRIGHT',BUTTON,'BOTTOMRIGHT',0,-10)
            _G['ActionButton'..i..'HotKey']:SetFont(UNIT_NAME_FONT,16,'OUTLINED')
            
            local hkBg = CreateFrame('Frame','GwHotKeyBackDropActionButton'..i, _G['ActionButton'..i.."HotKey"]:GetParent(),'GwActionHotKeyBackDrop')
            
            hkBg:SetPoint('CENTER',_G['ActionButton'..i.."HotKey"],'CENTER',0,0)
                  _G['GwHotKeyBackDropActionButton'..i..'Texture']:SetParent(_G['ActionButton'..i.."HotKey"]:GetParent())
            
            BUTTON:SetSize(MAIN_MENU_BAR_BUTTON_SIZE,MAIN_MENU_BAR_BUTTON_SIZE)
            BUTTON:ClearAllPoints()
            BUTTON:SetPoint('LEFT',MainMenuBarArtFrame,'LEFT',BUTTON_PADDING -MAIN_MENU_BAR_BUTTON_MARGIN - MAIN_MENU_BAR_BUTTON_SIZE,0)
            
            if i==6 then
                 BUTTON_PADDING = BUTTON_PADDING + 110
            end
            
            USED_WIDTH =  BUTTON_PADDING
            
        end       
    end
    MainMenuBarArtFrame:ClearAllPoints()
    MainMenuBarArtFrame:SetPoint('TOP',UIParent,'BOTTOM',0,80)
    MainMenuBarArtFrame:SetSize(BUTTON_PADDING,USED_HEIGHT)
end

function gw_updateCustomizableBars(barName,buttonName) 
    

    local BARSETTINGS = gwGetSetting(barName)
    
    
    
    local USED_WIDTH = 0
    local USED_HEIGHT = BARSETTINGS['size']
    
    local BUTTON_PADDING = 0
    local BUTTON_PADDING_y = 0
    local BUTTON_THIS_ROW = 0
    
    
    for i=1,12 do
        
        local BUTTON = _G[buttonName..i]
        
        if BUTTON~=nil then
            
           
            gw_updatehotkey(BUTTON)
            gw_setActionButtonStyle(buttonName..i,nil, gwGetSetting('HIDEACTIONBAR_BACKGROUND_ENABLED'))
            
            BUTTON:SetSize(BARSETTINGS['size'],BARSETTINGS['size'])
            BUTTON:ClearAllPoints()
            BUTTON:SetPoint('TOPLEFT',_G[barName],'TOPLEFT',BUTTON_PADDING,-BUTTON_PADDING_y)
            
            
            BUTTON_PADDING = BUTTON_PADDING + BARSETTINGS['size'] + BARSETTINGS['margin']
            
            BUTTON_THIS_ROW = BUTTON_THIS_ROW +1
            
            USED_WIDTH =  BUTTON_PADDING
            
            if BUTTON_THIS_ROW == BARSETTINGS['ButtonsPerRow'] then
                BUTTON_PADDING_y = BUTTON_PADDING_y + BARSETTINGS['size'] +BARSETTINGS['margin']
                BUTTON_THIS_ROW = 0
                BUTTON_PADDING = 0
                USED_HEIGHT = BUTTON_PADDING_y
            end
            
            
            
            
        end        
    end
    _G[barName]:ClearAllPoints()

    _G[barName]:SetPoint( BARSETTINGS['point'],UIParent, BARSETTINGS['relativePoint'], BARSETTINGS['xOfs'], BARSETTINGS['yOfs'])
    _G[barName]:SetSize(USED_WIDTH,USED_HEIGHT)
    
    
    
end


function gw_setPetBar()
    
    local BUTTON_SIZE = 24;
    local BUTTON_MARGIN = 2;
    local USED_WIDTH = 0
    
    PetActionButton1:ClearAllPoints()
    PetActionButton1:SetPoint('BOTTOMLEFT',GwPlayerPetFrame,'BOTTOMLEFT',3,3)

    for i=1,12 do
    
        if _G['PetActionButton'..i]~=nil then
            
            gw_updatehotkey(_G['PetActionButton'..i])
            
            _G['PetActionButton'..i]:SetSize(BUTTON_SIZE,BUTTON_SIZE)
            gw_setActionButtonStyle('PetActionButton'..i)
            
            if i>1 then
                _G['PetActionButton'..i]:SetPoint('LEFT',PetActionButton1,'RIGHT',USED_WIDTH,0);
            end   
            USED_WIDTH = (BUTTON_SIZE + BUTTON_MARGIN)*i
        end   
    end
    
end

function gw_setStanceBar()
    
    for i=1,12 do
        if _G["StanceButton"..i]~=nil then
            
            
        
            if i>1 then
            _G["StanceButton"..i]:ClearAllPoints()
                local last = i - 1
                
                _G["StanceButton"..i]:SetPoint('BOTTOM',_G['StanceButton'..last],'TOP',0,2)
            end
            
            _G["StanceButton"..i]:SetSize(38,38)
            gw_setActionButtonStyle('StanceButton'..i,true)
          
        end
    end
    
   
    CreateFrame('Button', 'GwStanceBarButton',UIParent,'GwStanceBarButton')
    GwStanceBarButton:SetPoint('TOPRIGHT',ActionButton1,'TOPLEFT',-5,2)
    CreateFrame('Frame', 'GwStanceBarContainer',UIParent,nil)
    GwStanceBarContainer:SetPoint('BOTTOM',GwStanceBarButton,'TOP',0,0)
    
    StanceBarFrame:SetParent(GwStanceBarContainer)
  
    StanceButton1:ClearAllPoints()
	StanceButton1:SetPoint('BOTTOM', StanceBarFrame, 'BOTTOM', 0, 0)
    

    StanceBarFrame:SetPoint('BOTTOMLEFT',GwStanceBarButton,'TOPLEFT',0,0)
    StanceBarFrame:SetPoint('BOTTOMRIGHT',GwStanceBarButton,'TOPRIGHT',0,0)


    GwStanceBarButton:RegisterEvent('CHARACTER_POINTS_CHANGED')
    GwStanceBarButton:RegisterEvent('PLAYER_ALIVE')
    GwStanceBarButton:RegisterEvent('UPDATE_SHAPESHIFT_FORM')
    GwStanceBarButton:RegisterEvent('UNIT_POWER')
    GwStanceBarButton:RegisterEvent('UNIT_HEALTH')
    GwStanceBarButton:SetScript('OnEvent',function() 

        if InCombatLockdown() then
            return
        end 

        if  GetNumShapeshiftForms()<1 then
            GwStanceBarButton:Hide()
        else
            GwStanceBarButton:Show()
        end
    end)
    

       
    if  GetNumShapeshiftForms()<1 then
        GwStanceBarButton:Hide()
    else
        GwStanceBarButton:Show()
    end
 
        
    GwStanceBarContainer:SetAlpha(0)
    
    GwStanceBarButton:SetScript('OnClick',function()
        if GwStanceBarContainer:GetAlpha()>0 then
                GwStanceBarContainer:SetAlpha(0)
        else
                GwStanceBarContainer:SetAlpha(1)
        end
    end) 
end


function gw_setbagFrame()
    
      if not gwGetSetting('BAGS_ENABLED') then
        CharacterBag0Slot:ClearAllPoints()
        CharacterBag1Slot:ClearAllPoints()
        CharacterBag2Slot:ClearAllPoints()
        CharacterBag3Slot:ClearAllPoints()

        MainMenuBarBackpackButton:SetPoint('RIGHT', ActionButton12, 'RIGHT', ActionButton12:GetWidth()+64, 0) 

        CharacterBag0Slot:SetPoint('LEFT', MainMenuBarBackpackButton, 'RIGHT', 0, 0) 
        CharacterBag1Slot:SetPoint('LEFT', CharacterBag0Slot, 'RIGHT', 0, 0) 
        CharacterBag2Slot:SetPoint('LEFT', CharacterBag1Slot, 'RIGHT', 0, 0) 
        CharacterBag3Slot:SetPoint('LEFT', CharacterBag2Slot, 'RIGHT', 0, 0) 

    end 
end

function gw_setLeaveVehicleButton()
    MainMenuBarVehicleLeaveButton:HookScript('OnShow',function() 
        MainMenuBarVehicleLeaveButton:ClearAllPoints();
        MainMenuBarVehicleLeaveButton:SetPoint('LEFT',ActionButton12,'RIGHT',0,0) 
    end)
end