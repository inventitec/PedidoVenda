object DM: TDM
  OldCreateOrder = True
  OnCreate = DataModuleCreate
  Height = 257
  Width = 394
  object DB: TFDConnection
    Params.Strings = (
      ''
      ''
      'Port=3050'
      'Server=localhost')
    LoginPrompt = False
    Left = 40
    Top = 16
  end
  object WaitCursor: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 40
    Top = 120
  end
  object FDPhysFBDriverLink: TFDPhysFBDriverLink
    Left = 40
    Top = 72
  end
end
