local Library = {}

-- Helper function to create a UI element
local function createUIElement(elementType, properties)
    local element = Instance.new(elementType)
    for property, value in pairs(properties) do
        element[property] = value
    end
    return element
end

-- Function to create a new window
function Library:CreateWindow(title, theme)
    local themes = {
        LightTheme = {Background = Color3.new(1, 1, 1), TextColor = Color3.new(0, 0, 0)},
        DarkTheme = {Background = Color3.new(0.2, 0.2, 0.2), TextColor = Color3.new(1, 1, 1)},
        GrapeTheme = {Background = Color3.new(0.3, 0, 0.3), TextColor = Color3.new(1, 1, 1)},
        BloodTheme = {Background = Color3.new(0.3, 0, 0), TextColor = Color3.new(1, 1, 1)},
        Ocean = {Background = Color3.new(0, 0.3, 0.3), TextColor = Color3.new(1, 1, 1)},
        Midnight = {Background = Color3.new(0, 0, 0.3), TextColor = Color3.new(1, 1, 1)},
        Sentinel = {Background = Color3.new(0.1, 0.1, 0.1), TextColor = Color3.new(1, 1, 1)},
        Synapse = {Background = Color3.new(0.2, 0.2, 0.2), TextColor = Color3.new(1, 1, 1)},
    }

    local themeColors = themes[theme] or themes.DarkTheme

    local ScreenGui = createUIElement("ScreenGui", {Name = "UI_Library", Parent = game.CoreGui})

    local MainFrame = createUIElement("Frame", {
        Name = "MainFrame",
        Parent = ScreenGui,
        BackgroundColor3 = themeColors.Background,
        Position = UDim2.new(0.5, -200, 0.5, -150),
        Size = UDim2.new(0, 400, 0, 300),
    })

    local TitleLabel = createUIElement("TextLabel", {
        Name = "TitleLabel",
        Parent = MainFrame,
        BackgroundColor3 = themeColors.Background,
        Size = UDim2.new(1, 0, 0, 50),
        Font = Enum.Font.SourceSans,
        Text = title,
        TextColor3 = themeColors.TextColor,
        TextSize = 24,
    })

    local Window = {MainFrame = MainFrame, ThemeColors = themeColors}

    function Window:NewTab(name)
        local TabButton = createUIElement("TextButton", {
            Parent = MainFrame,
            BackgroundColor3 = themeColors.Background,
            TextColor3 = themeColors.TextColor,
            Text = name,
            Size = UDim2.new(0, 100, 0, 30),
            Font = Enum.Font.SourceSans,
            TextSize = 18,
        })

        local TabFrame = createUIElement("Frame", {
            Parent = MainFrame,
            BackgroundColor3 = themeColors.Background,
            Size = UDim2.new(1, 0, 1, -50),
            Position = UDim2.new(0, 0, 0, 50),
            Visible = false,
        })

        TabButton.MouseButton1Click:Connect(function()
            for _, v in pairs(MainFrame:GetChildren()) do
                if v:IsA("Frame") and v ~= TabFrame then
                    v.Visible = false
                end
            end
            TabFrame.Visible = true
        end)

        return {
            TabFrame = TabFrame,
            NewSection = function(_, sectionName)
                local SectionFrame = createUIElement("Frame", {
                    Parent = TabFrame,
                    BackgroundColor3 = themeColors.Background,
                    Size = UDim2.new(1, 0, 0, 200),
                    Position = UDim2.new(0, 0, 0, 0),
                })

                local SectionLabel = createUIElement("TextLabel", {
                    Parent = SectionFrame,
                    BackgroundColor3 = themeColors.Background,
                    TextColor3 = themeColors.TextColor,
                    Text = sectionName,
                    Size = UDim2.new(1, 0, 0, 30),
                    Font = Enum.Font.SourceSans,
                    TextSize = 18,
                })

                local Section = {SectionFrame = SectionFrame}

                function Section:UpdateSection(newTitle)
                    SectionLabel.Text = newTitle
                end

                function Section:NewLabel(text)
                    return createUIElement("TextLabel", {
                        Parent = SectionFrame,
                        BackgroundColor3 = themeColors.Background,
                        TextColor3 = themeColors.TextColor,
                        Text = text,
                        Size = UDim2.new(1, 0, 0, 30),
                        Font = Enum.Font.SourceSans,
                        TextSize = 18,
                    })
                end

                function Section:NewButton(text, info, callback)
                    local Button = createUIElement("TextButton", {
                        Parent = SectionFrame,
                        BackgroundColor3 = themeColors.Background,
                        TextColor3 = themeColors.TextColor,
                        Text = text,
                        Size = UDim2.new(1, 0, 0, 30),
                        Font = Enum.Font.SourceSans,
                        TextSize = 18,
                    })

                    Button.MouseButton1Click:Connect(callback)

                    function Button:UpdateButton(newText)
                        Button.Text = newText
                    end

                    return Button
                end

                function Section:NewToggle(text, info, callback)
                    local Toggle = createUIElement("TextButton", {
                        Parent = SectionFrame,
                        BackgroundColor3 = themeColors.Background,
                        TextColor3 = themeColors.TextColor,
                        Text = text,
                        Size = UDim2.new(1, 0, 0, 30),
                        Font = Enum.Font.SourceSans,
                        TextSize = 18,
                    })

                    local toggled = false

                    Toggle.MouseButton1Click:Connect(function()
                        toggled = not toggled
                        callback(toggled)
                        Toggle.Text = text .. (toggled and " [ON]" or " [OFF]")
                    end)

                    function Toggle:UpdateToggle(newState)
                        toggled = newState
                        Toggle.Text = text .. (toggled and " [ON]" or " [OFF]")
                    end

                    return Toggle
                end

                function Section:NewSlider(text, info, max, min, callback)
                    local SliderFrame = createUIElement("Frame", {
                        Parent = SectionFrame,
                        BackgroundColor3 = themeColors.Background,
                        Size = UDim2.new(1, 0, 0, 30),
                    })

                    local SliderBar = createUIElement("Frame", {
                        Parent = SliderFrame,
                        BackgroundColor3 = themeColors.TextColor,
                        Size = UDim2.new(1, -10, 0, 5),
                        Position = UDim2.new(0, 5, 0.5, -2.5),
                    })

                    local SliderButton = createUIElement("TextButton", {
                        Parent = SliderBar,
                        BackgroundColor3 = themeColors.Background,
                        Size = UDim2.new(0, 10, 1, 0),
                        Text = "",
                    })

                    local function updateSlider(input)
                        local pos = UDim2.new(math.clamp((input.Position.X - SliderBar.AbsolutePosition.X) / SliderBar.AbsoluteSize.X, 0, 1), 0, 0, 0)
                        SliderButton.Position = pos
                        local value = min + (max - min) * pos.X.Scale
                        callback(value)
                    end

                    SliderButton.InputBegan:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            updateSlider(input)
                            local moveConnection, releaseConnection

                            moveConnection = game:GetService("UserInputService").InputChanged:Connect(function(input)
                                if input.UserInputType == Enum.UserInputType.MouseMovement then
                                    updateSlider(input)
                                end
                            end)

                            releaseConnection = game:GetService("UserInputService").InputEnded:Connect(function(input)
                                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                                    moveConnection:Disconnect()
                                    releaseConnection:Disconnect()
                                end
                            end)
                        end
                    end)

                    return SliderFrame
                end

                function Section:NewTextBox(text, info, callback)
                    local TextBox = createUIElement("TextBox", {
                        Parent = SectionFrame,
                        BackgroundColor3 = themeColors.Background,
                        TextColor3 = themeColors.TextColor,
                        Text = "",
                        PlaceholderText = text,
                        Size = UDim2.new(1, 0, 0, 30),
                        Font = Enum.Font.SourceSans,
                        TextSize = 18,
                    })

                    TextBox.FocusLost:Connect(function(enterPressed)
                        if enterPressed then
                            callback(TextBox.Text)
                        end
                    end)

                    return TextBox
                end
                local KeybindButton = createUIElement("TextButton", {
                    Parent = SectionFrame,
                    BackgroundColor3 = themeColors.Background,
                    TextColor3 = themeColors.TextColor,
                    Text = "Key: " .. key.Name,
                    Size = UDim2.new(1, 0, 0, 30),
                    Font = Enum.Font.SourceSans,
                    TextSize = 18,
                })

                KeybindButton.MouseButton1Click:Connect(function()
                    KeybindButton.Text = "Press a key..."
                    local keyPress
                    keyPress = game:GetService("UserInputService").InputBegan:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.Keyboard then
                            callback(input.KeyCode)
                            KeybindButton.Text = "Key: " .. input.KeyCode.Name
                            keyPress:Disconnect()
                        end
                    end)
                end)

                return KeybindButton
            end

            function Section:NewDropdown(text, info, options, callback)
                local DropdownFrame = createUIElement("Frame", {
                    Parent = SectionFrame,
                    BackgroundColor3 = themeColors.Background,
                    Size = UDim2.new(1, 0, 0, 30),
                })

                local Dropdown = createUIElement("TextLabel", {
                    Parent = DropdownFrame,
                    BackgroundColor3 = themeColors.Background,
                    TextColor3 = themeColors.TextColor,
                    Text = "Select an option...",
                    Size = UDim2.new(1, 0, 1, 0),
                    Font = Enum.Font.SourceSans,
                    TextSize = 18,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextYAlignment = Enum.TextYAlignment.Center,
                })

                local DropdownOptionsFrame = createUIElement("Frame", {
                    Parent = DropdownFrame,
                    BackgroundColor3 = themeColors.Background,
                    Position = UDim2.new(0, 0, 1, 0),
                    Size = UDim2.new(1, 0, 0, 0),
                    Visible = false,
                    ZIndex = 2,
                })

                for _, option in ipairs(options) do
                    local OptionButton = createUIElement("TextButton", {
                        Parent = DropdownOptionsFrame,
                        BackgroundColor3 = themeColors.Background,
                        TextColor3 = themeColors.TextColor,
                        Text = option,
                        Size = UDim2.new(1, 0, 0, 30),
                        Font = Enum.Font.SourceSans,
                        TextSize = 18,
                    })

                    OptionButton.MouseButton1Click:Connect(function()
                        callback(option)
                        Dropdown.Text = option
                        DropdownOptionsFrame.Visible = false
                    end)
                end

                Dropdown.MouseButton1Click:Connect(function()
                    DropdownOptionsFrame.Visible = not DropdownOptionsFrame.Visible
                end)

                return DropdownFrame
            end

            function Section:NewColorPicker(text, info, defaultColor, callback)
                local ColorPickerFrame = createUIElement("Frame", {
                    Parent = SectionFrame,
                    BackgroundColor3 = themeColors.Background,
                    Size = UDim2.new(1, 0, 0, 100),
                })

                local ColorPicker = createUIElement("Frame", {
                    Parent = ColorPickerFrame,
                    BackgroundColor3 = defaultColor,
                    BorderSizePixel = 0,
                    Size = UDim2.new(0.8, 0, 0.8, 0),
                    Position = UDim2.new(0, 0, 0.1, 0),
                })

                local ColorPickerButton = createUIElement("TextButton", {
                    Parent = ColorPickerFrame,
                    BackgroundColor3 = themeColors.Background,
                    TextColor3 = themeColors.TextColor,
                    Text = "Pick a color...",
                    Size = UDim2.new(1, 0, 0, 30),
                    Font = Enum.Font.SourceSans,
                    TextSize = 18,
                })

                ColorPickerButton.MouseButton1Click:Connect(function()
                    local pickedColor = Color3.new(1, 1, 1) -- Default color
                    local success, result = pcall(function()
                        return game:GetService("ColorPickerPrompt").PromptColor()
                    end)
                    if success and result then
                        pickedColor = result
                    end
                    ColorPicker.BackgroundColor3 = pickedColor
                    callback(pickedColor)
                end)

                return ColorPickerFrame
            end

            return Section
        end,
    }

    return Window
end
end

return Library
