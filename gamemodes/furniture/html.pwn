furniture_PrintPage( )
{
    new string[1000], orig_category[ 50 ], _items,
		orig_subcat[ 50 ],	File:hFile;
	hFile = fopen("Furniture_Prices.html", io_write);
	new price ;
	for( new i; i < sizeof(furniture_inventory); i++ )
	{
		if( strcmp( orig_category, furniture_inventory[ i ][ f_inven_category ] ) || !strlen( orig_category ) )
		{
			if( strlen( orig_category ) )
				fwrite( hFile, "</table>\n" );
			format( orig_category, sizeof( orig_category ), furniture_inventory[ i ][ f_inven_category ] );
			format( string, sizeof( string ), "<table>\n<th><h2>%s</h2></th>\n", furniture_inventory[ i ][ f_inven_category ] );
			fwrite( hFile, string );
		}
		if( strcmp( orig_subcat, furniture_inventory[ i ][ f_inven_sub_category ] ) || !strlen( orig_subcat ) )
		{
			format( orig_subcat, sizeof( orig_subcat ), furniture_inventory[ i ][ f_inven_sub_category ] );
			format( string, sizeof( string ), "<tr><th>%s</th></tr>\n", furniture_inventory[ i ][ f_inven_sub_category ] );
			fwrite( hFile, string );
		}
		price = furniture_inventory[ i ][ f_inven_price ] / 10;

		format( string, sizeof( string ),"<tr><td><img src=\"https://files.prineside.com/gtasa_samp_model_id/blue/%d_b.jpg\" alt=\"\" border=\"3\" height=\"100\" width=\"100\"></td><td><b>%s</b></td><td><font color=\"green\">$%s</font></td><td><b>Model ID %d</b></td></tr>\n", furniture_inventory[ i ][f_inven_model], furniture_inventory[ i ][ f_inven_name ], IntegerWithDelimiter( price ), furniture_inventory[ i ][ f_inven_model ] );
		fwrite( hFile, string );
		_items++;
	}
	fwrite( hFile, "</table>\n" );
	format( string, sizeof( string ),"<h1><font color=\"red\">%d<font> Items!</h1>", _items );
	fwrite( hFile, string );
	fclose( hFile );
	return 1;
}

public OnGameModeInit() {

	furniture_PrintPage();
	
	#if defined furni_OnGameModeInit
		return furni_OnGameModeInit();
	#else
		return 1;
	#endif
}
#if defined _ALS_OnGameModeInit
	#undef OnGameModeInit
#else
	#define _ALS_OnGameModeInit
#endif

#define OnGameModeInit furni_OnGameModeInit
#if defined furni_OnGameModeInit
	forward furni_OnGameModeInit();
#endif