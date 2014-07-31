# LegacyData

This is a WIP pre-production ETL rails add-on (may evolve into a gem) that enables the extraction, transformation and loading of data from various source formats.  The tool allows develoeprs to define a repeatable process that extracts data from a set of sources, apply filters to that data to exclude any outliers and import the data into their Rails application.  The idea is that the process can be iterative allowing tweaks to be made to the script to refine the import over time.

## Recommended Requirements
* Postgres 9.3.4 or MySQL 14.14 (Postgre required to take advantage of JSON columns)
* Rails 4
* Ruby 2'

## Installation Instructions
TBD

## Usage Instructions
1. Fill in extractor.rb to convert the raw source data into a JSON blob with the values you want to import.  This is a good place to convert date formats, map enumerable values, etc...  Any basic manipulation of input fields should be done here but avoid referencing any Rails models as that can be done later in the import phase.
2. Create filters as required for legacy sources.  In these filters, you can filter out certain records due to missing fields (e.g. ID, Name, Identification Number, etc...).
3. Fill in importer.rb to accept the filtered legacy entities generated thus far and use them to create objects in the system as applicable.  Here is where the more sophisticated logic can go to create/udpate objects in the system.  Every object created here can be associated back to its source legacy entity to make it easy to see where the data came from.
4. Review and updated the legacy script as neccesairy to support your extractor, filters and importer.  This is the script you can use to run the end to end data import.
