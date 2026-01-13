USING System
USING System.Collections.Generic
USING System.ComponentModel
USING System.IO
USING System.Linq
USING System.Text
USING System.Globalization
USING System.Threading.Tasks
USING System.Windows
USING System.Windows.Controls
USING System.Windows.Data
USING System.Windows.Documents
USING System.Windows.Input
USING System.Windows.Media
USING System.Windows.Media.Imaging
USING System.Windows.Navigation
USING System.Windows.Shapes
USING System.Net
USING System.Net.Http
USING System.Text.Json
USING Pokedex

BEGIN NAMESPACE Pokedex
    
/// <summary>
/// Interaction logic for MainWindow.xaml
/// </summary>
PUBLIC PARTIAL CLASS MainWindow ;
        INHERIT Window;
        IMPLEMENTS INotifyPropertyChanged
    
    // Pageination properties
    PRIVATE _pageinatelimit := 15 AS INT
    PRIVATE _pageinateOffset := 0 AS INT
    PRIVATE _maxRecords := 151 AS INT
    PUBLIC PROPERTY HasNext AS LOGIC
        GET
            RETURN _pageinateOffset +_pageinatelimit < _maxRecords
        END GET
    END PROPERTY
    
    PUBLIC PROPERTY HasPrevious AS LOGIC
        GET
            RETURN _pageinateOffset > 0
        END GET
    END PROPERTY
    
    PUBLIC CONSTRUCTOR() STRICT
        InitializeComponent()
        SELF:DataContext := SELF
        LoadPokemon(GetUrl())
        RETURN
    END CONSTRUCTOR
    
    // Populate ListBox
    ASYNC METHOD LoadPokemon(url AS STRING) AS Task
        LOCAL PokemonList AS List<Pokemon>
        PokemonList := AWAIT SELF:GetPokemonAsync(url)
        PokemonNameList:Items:Clear()
        
        FOREACH p AS Pokemon IN PokemonList
            SELF:PokemonNameList:Items:Add(p)
        NEXT
        
    END METHOD
    
    // Call API TO GET list OF Pokemon
    ASYNC METHOD GetPokemonAsync(url AS STRING) AS Task<List<Pokemon>>
        LOCAL client := HttpClient{} AS HttpClient
        LOCAL PokemonList AS List<Pokemon>
        
        TRY
            LOCAL response AS STRING
            LOCAL jsonDoc  AS JsonDocument
            LOCAL results AS JsonElement
            LOCAL Pokemon AS Pokemon
            
            response := AWAIT client:GetStringAsync(url)
            jsonDoc := JsonDocument.Parse(response)
            results := jsonDoc:RootElement:GetProperty("results")
            PokemonList := List<Pokemon>{}
            
            FOREACH VAR item IN results:EnumerateArray()
                VAR pURL := item:GetProperty("url"):GetString()
                VAR tags := pURL:Split('/')
                VAR tagNum := val(tags[tags:Length - 1])
                Pokemon := Pokemon{tagNum,item:GetProperty("name"):GetString(),pURL}
                PokemonList:Add(Pokemon)
                console.WriteLine()
            NEXT
            
        CATCH e AS Exception
            MessageBox.Show(e:Message, "Error")
        END TRY
        
        RETURN PokemonList:OrderBy({p => p:id}):toList()
        
    END METHOD
    
    // Click into Pokemon to display stats and sprite
    ASYNC METHOD PokemonNameList_MouseDoubleClick(sender AS System.Object, e AS System.Windows.Input.MouseButtonEventArgs) AS VOID STRICT
        
        LOCAL Pokemon AS Pokemon
        
        Pokemon := ((Pokemon) PokemonNameList:SelectedItem)
        
        IF Pokemon == NULL
            RETURN
        ENDIF
        
        PokemonNameList:Visibility := Visibility.Collapsed
        LoadingBar:Visibility := Visibility.Visible
        StatsPanel:Children:Clear()
        Sprite:Source := NIL
        PokemonName:Text := Pokemon:Name
        
        AWAIT LoadPokemonDetails(Pokemon)
        
        DetailsPanel:Visibility := Visibility.Visible
        
        RETURN
    END METHOD
    
    // Load spcecific pokemon details
    ASYNC METHOD LoadPokemonDetails(Pokemon AS Pokemon) AS task
        LOCAL client := HttpClient{} AS HttpClient
        TRY
            LOCAL response AS STRING
            LOCAL jsonDoc  AS JsonDocument
            LOCAL statsData AS JsonElement
            LOCAL spritePath AS STRING
            
            response := AWAIT client:GetStringAsync(Pokemon:URL)
            jsonDoc := JsonDocument.Parse(response)
            statsData := jsonDoc:RootElement:GetProperty("stats")
            spritePath := jsonDoc:RootElement:GetProperty("sprites"):GetProperty("other"):GetProperty("official-artwork"):GetProperty("front_default"):GetString()
            
            AWAIT LoadSprite(spritePath)
            AWAIT LoadStatsString(statsData)
            
            pHeight:Text := "Height " + jsonDoc:RootElement:GetProperty("height"):GetInt32():ToString()
            pWeight:Text  :="Weight " + jsonDoc:RootElement:GetProperty("weight"):GetInt32():ToString()
            
        CATCH err AS Exception
            MessageBox.Show(err:Message, "Error")
            
        FINALLY
            LoadingBar:Visibility := Visibility.Collapsed
        END TRY
        
    END METHOD
    
    
    // Get sprite - uses official-artwork:front_default
    ASYNC METHOD LoadSprite(spritePath AS STRING) AS TASK
        
        LOCAL bitmap AS BitmapImage
        LOCAL client := HttpClient{} AS HttpClient
        LOCAL stream AS MemoryStream
        
        IF Empty(spritePath) .OR. spritePath == NULL
            RETURN
        ENDIF
        
        TRY
            
            ServicePointManager.SecurityProtocol := SecurityProtocolType.Tls12;
                
            // Download image bytes manually & load into bitmap by byte
            client := HttpClient{}
            bitmap := BitmapImage{}
            stream := MemoryStream{AWAIT client:GetByteArrayAsync(spritePath)}
            
            
            bitmap:BeginInit()
            bitmap:StreamSource := stream
            bitmap:CacheOption := BitmapCacheOption.OnLoad
            bitmap:EndInit()
            bitmap:Freeze()
            
            Sprite:Source := bitmap
            
        CATCH e AS Exception
            MessageBox.Show("Failed to load sprite: " + e:Message)
        END TRY
        
    END METHOD
    
    // Get Stats - name and details
    ASYNC METHOD LoadStatsString(statsData AS JsonElement ) AS TASK
        LOCAL sb AS StringBuilder
        LOCAL textInfo AS TextInfo
        
        TextInfo := CultureInfo.CurrentCulture:TextInfo
        sb:= StringBuilder{}
        
        FOREACH VAR s IN statsData:EnumerateArray()
            LOCAL statName := s:GetProperty("stat"):GetProperty("name"):GetString()
            LOCAL baseStat := s:GetProperty("base_stat"):GetInt32()
            
            // Label
            LOCAL lbl AS TextBlock
            lbl := TextBlock{}
            lbl:Text := TextInfo:ToTitleCase(statName) + "  " + baseStat:toString()
            lbl:FontWeight := FontWeights.Bold
            lbl:Margin := Thickness{0,2,0,0}
            
            // ProgressBar
            LOCAL bar AS ProgressBar
            bar := ProgressBar{}
            bar:Minimum := 0
            bar:Maximum := 255
            bar:Value := baseStat
            bar:Height := 5
            bar:Foreground := Brushes.Green
            bar:Margin := Thickness{0,0,0,2}
            
            // Add to panel
            StatsPanel:Children:Add(lbl)
            StatsPanel:Children:Add(bar)
        NEXT
        
        
    END METHOD
    
    // Return to main pokemon list
    ASYNC METHOD BackButton_Click(sender AS System.Object, e AS RoutedEventArgs) AS VOID STRICT
        
        DetailsPanel:Visibility := Visibility.Collapsed
        Sprite:Source := NIL
        StatsPanel:Children:Clear()
        PokemonName:Text := ""
        PokemonNameList:Visibility := Visibility.Visible
        
    END METHOD
    
    // Get Next pokemon in list
    ASYNC METHOD GetNextButton_Click(sender AS System.Object, e AS System.Windows.RoutedEventArgs) AS VOID STRICT
        IF HasNext
            
            _pageinateOffset +=  _pageinatelimit
            SELF:RaisePropertyChanged("HasNext")
            SELF:RaisePropertyChanged("HasPrevious")
            AWAIT LoadPokemon(GetUrl() )
            
        ENDIF
        RETURN
    END METHOD
    
    // Get Preivous pokemon in list
    ASYNC METHOD GetPreviousButton_Click(sender AS System.Object, e AS System.Windows.RoutedEventArgs) AS VOID STRICT
        IF HasPrevious
            
            _pageinateOffset -= _pageinatelimit
            SELF:RaisePropertyChanged("HasNext")
            SELF:RaisePropertyChanged("HasPrevious")
            AWAIT LoadPokemon(GetUrl() )
        ENDIF
        RETURN
    END METHOD
    
    // Deterime the url to use
    METHOD GetUrl() AS STRING
        LOCAL Limit AS INT
        Limit := MIN(_pageinatelimit,  _maxRecords - _pageinateOffset)
        RETURN "https://pokeapi.co/api/v2/pokemon?limit=" + Limit:ToString() + "&offset=" + _pageinateOffset:ToString()
    END METHOD
    
    PUBLIC EVENT PropertyChanged AS PropertyChangedEventHandler
        
        // Raised changes to properties, used to enable/disable next and previous buttons
    PRIVATE METHOD RaisePropertyChanged(propertyName AS STRING) AS VOID
        IF PropertyChanged <> NULL
            PropertyChanged(SELF, PropertyChangedEventArgs{propertyName})
        ENDIF
    END METHOD
    
END CLASS
END NAMESPACE
