// Pokemon.prg
// Created by    : CherylDunn
// Creation Date : 1/9/2026 3:48:23 PM
// Created for   :
// WorkStation   : LAPTOP-U2T07M55


USING System
USING System.Collections.Generic
USING System.Text
USING System.Globalization

BEGIN NAMESPACE Pokedex
    
/// <summary>
/// Class Defining a Pokemon with Name & URL.
/// </summary>
CLASS Pokemon
    
    PUBLIC PROPERTY  Name AS STRING AUTO
    PUBLIC PROPERTY  URL AS STRING AUTO
    PUBLIC PROPERTY  ID AS INT AUTO
    PUBLIC PROPERTY DisplayName AS STRING
        GET
            RETURN ei"{ID}. {Name}"
        END GET
    END PROPERTY
    
    
    CONSTRUCTOR(id AS INT, name AS STRING, url AS STRING)
        SELF:ID := id
        SELF:Name := getProperName(name)
        SELF:URL := url
    END CONSTRUCTOR
    
    
    PRIVATE METHOD getProperName( name AS STRING) AS STRING
        LOCAL textInfo AS TextInfo
        LOCAL result AS STRING
        TextInfo := CultureInfo.CurrentCulture:TextInfo
        result := TextInfo:ToTitleCase(name)
        RETURN result
    END METHOD
    
    
END CLASS

END NAMESPACE
