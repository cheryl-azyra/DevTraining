// Pokemon.prg
// Created by    : CherylDunn
// Creation Date : 1/9/2026 3:48:23 PM
// Created for   :
// WorkStation   : LAPTOP-U2T07M55


USING System
USING System.Collections.Generic
USING System.Text
USING System.Globalization
USING System.Text.Json.Serialization
USING System.Text.Json

BEGIN NAMESPACE Pokedex
    
/// <summary>
/// defining base pokemon models
/// </summary>
CLASS Pokemon
    PUBLIC PROPERTY  Name AS STRING AUTO
    PUBLIC PROPERTY  URL AS STRING AUTO
    PUBLIC PROPERTY  ID AS INT AUTO
    PUBLIC PROPERTY DisplayName AS STRING
        GET
            LOCAL textInfo AS TextInfo
            TextInfo := CultureInfo.CurrentCulture:TextInfo
            RETURN ei"{ID}. {textInfo:ToTitleCase(Name)}"
        END GET
    END PROPERTY
    
    CONSTRUCTOR(id AS INT, name AS STRING, url AS STRING)
        SELF:ID := id
        SELF:Name := name
        SELF:URL := url
    END CONSTRUCTOR
END CLASS

CLASS PokemonApiResponse
    PUBLIC PROPERTY results AS List<Pokemon> AUTO
    PUBLIC PROPERTY next AS STRING AUTO
    PUBLIC PROPERTY previous AS  STRING AUTO
    PUBLIC PROPERTY count AS  INT AUTO
END CLASS


CLASS PokemonStat
    PUBLIC PROPERTY base_stat AS INT AUTO
    PUBLIC PROPERTY stat AS PokemonStatInfo AUTO
END CLASS


CLASS PokemonStatInfo
    PUBLIC PROPERTY name AS STRING AUTO
        
    PUBLIC PROPERTY DisplayName AS STRING
        GET
            LOCAL textInfo AS TextInfo
            TextInfo := CultureInfo.CurrentCulture:TextInfo
            RETURN textInfo:ToTitleCase(name)
        END GET
    END PROPERTY
END CLASS


CLASS PokemonDetailsResponse
    PUBLIC PROPERTY height AS INT AUTO
    PUBLIC PROPERTY weight AS INT AUTO
    PUBLIC PROPERTY stats  AS List<PokemonStat> AUTO
END CLASS

END NAMESPACE
