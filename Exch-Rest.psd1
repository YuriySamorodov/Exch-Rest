﻿#
# Module manifest for module 'Exch-Rest'
#
# Generated by: Glen Scales gscales@msgdevelop.com
#
# Generated on: 2/05/2017
#

@{
	
	# Script module or binary module file associated with this manifest.
	RootModule		   = 'Exch-Rest'
	
	
	# Version number of this module.
	ModuleVersion	   = '2.5'
	
	# Supported PSEditions
	# CompatiblePSEditions = @()
	
	# ID used to uniquely identify this module
	GUID			   = 'fa6095ab-c4b8-4919-ae37-d09d00d23bb3'
	
	# Author of this module
	Author			   = 'Glen Scales'
	
	# Company or vendor of this module
	CompanyName	       = 'MSGDevelop'
	
	# Copyright statement for this module
	Copyright		   = '(c) 2017 Glen Scales. All rights reserved.'
	
	# Description of the functionality provided by this module
	Description	       = 'Module for helping to use the Outlook REST API on Office365 and Exchange 2016'
	
	# Minimum version of the Windows PowerShell engine required by this module
	# PowerShellVersion = ''
	
	# Name of the Windows PowerShell host required by this module
	# PowerShellHostName = ''
	
	# Minimum version of the Windows PowerShell host required by this module
	# PowerShellHostVersion = ''
	
	# Minimum version of Microsoft .NET Framework required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
	# DotNetFrameworkVersion = ''
	
	# Minimum version of the common language runtime (CLR) required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
	# CLRVersion = ''
	
	# Processor architecture (None, X86, Amd64) required by this module
	# ProcessorArchitecture = ''
	
	# Modules that must be imported into the global environment prior to importing this module
	# RequiredModules = @()
	
	# Assemblies that must be loaded prior to importing this module
	# RequiredAssemblies = @()
	
	# Script files (.ps1) that are run in the caller's environment prior to importing this module.
	# ScriptsToProcess = @()
	
	# Type files (.ps1xml) to be loaded when importing this module
	# TypesToProcess = @()
	
	# Format files (.ps1xml) to be loaded when importing this module
	FormatsToProcess = @("xml\PoshExchRest.Format.ps1xml")
	
	# Modules to import as nested modules of the module specified in RootModule/ModuleToProcess
	# NestedModules = @()
	
	# Functions to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no functions to export.
	FunctionsToExport  = @(
		'Convert-FromBase64StringWithNoPadding',
		'Export-ContactFolderToCSV',
		'Find-MeetingTimes',
		'Find-Rooms',
		'Get-AccessToken',
		'Get-AccessTokenUserAndPass',
		'Get-AllCalendarFolders',
		'Get-AllChildFolders',
		'Get-AllContactFolders',
		'Get-AllMailboxItems',
		'Get-AllMailFolders',
		'Get-AllTaskfolders',
		'Get-AppOnlyToken',
		'Get-AppSettings',
		'Get-ArchiveFolder',
		'Get-Attachments',
		'Get-AutomaticRepliesSettings',
		'Get-CalendarFolder',
		'Get-CalendarGroups',
		'Get-CalendarView',
		'Get-ChannelInformation',
		'Get-Contacts',
		'Get-ContactsFolder',
		'Get-DefaultCalendarFolder',
		'Get-DefaultContactsFolder',
		'Get-DefaultOneDrive',
		'Get-DefaultOneDriveRootItems',
		'Get-EmailActivity',
		'Get-EndPoint',
		'Get-EventJSONFormat',
		'Get-EXRItemRetentionTags',
		'Get-EXRRetainedPurgesFolderItems',
		'Get-EXRWellKnownFolder',
		'Get-ExtendedPropList',
		'Get-FocusedInboxItems',
		'Get-FolderClass',
		'Get-FolderFromPath',
		'Get-FolderItems',
		'Get-FolderPath',
		'Get-GroupChannels',
		'Get-GroupConversations',
		'Get-HTTPClient',
		'Get-Inbox',
		'Get-InboxItems',
		'Get-InboxRule',
		'Get-ItemProp',
		'Get-MailAppProps',
		'Get-MailboxSettings',
		'Get-MailboxSettingsReport',
		'Get-MailboxTimeZone',
		'Get-MailboxUsage',
		'Get-MailboxUser',
		'Get-MessageJSONFormat',
		'Get-ModernGroups',
		'Get-NamedProperty',
		'Get-ObjectCollectionProp',
		'Get-ObjectProp',
		'Get-Office365ActiveUsers',
		'Get-OneDriveChildren',
		'Get-OneDriveItem',
		'Get-OneDriveItemFromPath',
		'Get-People',
		'Get-ProtectedToken',
		'Get-RecoverableItemsFolders',
		'Get-Recurrence',
		'Get-RootMailFolder',
		'Get-StandardProperty',
		'Get-TaggedProperty',
		'Get-TestAccessToken',
		'Get-TestAppToken',
		'Get-TokenFromSecureString',
		'Get-UserPhoto',
		'Get-UserPhotoMetaData',
		'Get-Users',
		'Get-WellKnownFolderItems',
		'Import-AccessToken',
		'Import-ModuleFile',
		'Invoke-CreateSelfSignedCert',
		'Invoke-DecodeToken',
		'Invoke-DeleteFolder',
		'Invoke-DeleteItem',
		'Invoke-DownloadAttachment',
		'Invoke-EnumCalendarGroups',
		'Invoke-EnumChildFolders',
		'Invoke-EnumOneDriveFolders',
		'Invoke-EXRParseExtendedProperties',
		'Invoke-FolderPicker',
		'Invoke-MailFolderPicker',
		'Invoke-OneDriveFolderPicker',
		'Invoke-RefreshAccessToken',
		'Invoke-RestDELETE',
		'Invoke-RestGet',
		'Invoke-RestPatch',
		'Invoke-RestPOST',
		'Invoke-RestPut',
		'Invoke-UploadOneDriveItemToPath',
		'Move-EXRMessage',
        'Copy-EXRMessage',
		'New-Attendee',
		'New-CalendarEventREST',
		'New-CalendarFolder',
		'New-ContactFolder',
		'New-EmailAddress',
		'New-Folder',
		'New-HolidayEvent',
		'New-InboxRule',
		'New-JWTToken',
		'New-ReferanceAttachment',
		'New-SentEmailMessage',
		'Remove-InboxRule',
		'Rename-Folder',
		'Send-MessageREST',
		'Send-SimpleMeetingRequest',
		'Set-FolderRetentionTag',
		'Set-InboxRule',
		'Show-OAuthWindow',
		'Update-Folder',
		'Update-FolderClass',
		'Update-Message'
	)
	
	# Cmdlets to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no cmdlets to export.
	CmdletsToExport    = @()
	
	# Variables to export from this module
	VariablesToExport  = '*'
	
	# Aliases to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no aliases to export.
	AliasesToExport    = @()
	
	# DSC resources to export from this module
	# DscResourcesToExport = @()
	
	# List of all modules packaged with this module
	# ModuleList = @()
	
	# List of all files packaged with this module
	FileList		   = 'Exch-Rest.psm1'
	
	# Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
	PrivateData	       = @{
		
		PSData  = @{
			
			# Tags applied to this module. These help with module discovery in online galleries.
			# Tags = @()
			
			# A URL to the license for this module.
			LicenseUri    = 'https://github.com/gscales/Exch-Rest/blob/master/LICENSE.txt'
			
			# A URL to the main website for this project.
			ProjectUri    = 'https://github.com/gscales/Exch-Rest'
			
			# A URL to an icon representing this module.
			# IconUri = ''
			
			# ReleaseNotes of this module
			ReleaseNotes  = 'https://github.com/gscales/Exch-Rest'
			
		} # End of PSData hashtable
		
	} # End of PrivateData hashtable
	
	# HelpInfo URI of this module
	# HelpInfoURI = ''
	
	# Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
	# DefaultCommandPrefix = ''
	
}

