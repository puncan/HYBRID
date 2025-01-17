#Licensed under Apache 2.0 License.
#© 2020 Battelle Energy Alliance, LLC
#ALL RIGHTS RESERVED
#.
#Prepared by Battelle Energy Alliance, LLC
#Under Contract No. DE-AC07-05ID14517
#With the U. S. Department of Energy
#.
#NOTICE:  This computer software was prepared by Battelle Energy
#Alliance, LLC, hereinafter the Contractor, under Contract
#No. AC07-05ID14517 with the United States (U. S.) Department of
#Energy (DOE).  The Government is granted for itself and others acting on
#its behalf a nonexclusive, paid-up, irrevocable worldwide license in this
#data to reproduce, prepare derivative works, and perform publicly and
#display publicly, by or on behalf of the Government. There is provision for
#the possible extension of the term of this license.  Subsequent to that
#period or any extension granted, the Government is granted for itself and
#others acting on its behalf a nonexclusive, paid-up, irrevocable worldwide
#license in this data to reproduce, prepare derivative works, distribute
#copies to the public, perform publicly and display publicly, and to permit
#others to do so.  The specific term of the license can be identified by
#inquiry made to Contractor or DOE.  NEITHER THE UNITED STATES NOR THE UNITED
#STATES DEPARTMENT OF ENERGY, NOR CONTRACTOR MAKES ANY WARRANTY, EXPRESS OR
#IMPLIED, OR ASSUMES ANY LIABILITY OR RESPONSIBILITY FOR THE USE, ACCURACY,
#COMPLETENESS, OR USEFULNESS OR ANY INFORMATION, APPARATUS, PRODUCT, OR
#PROCESS DISCLOSED, OR REPRESENTS THAT ITS USE WOULD NOT INFRINGE PRIVATELY
#OWNED RIGHTS.
'''
This module provides functions to analyse FMUs.

'''

def get_dependencies(fmu_file_name):
    '''Return the input and state dependencies of an FMU as a dictionary.

    :fmu_file_name: Name of the FMU file.

    Extracts the FMU ``fmu_file_name`` to a temporary directory,
    reads its `modelDescription.xml` file,
    and returns a dictionary with the dependencies of derivatives,
    outputs and initial unknowns.

    For example, if applied to an FMU that encapsulates the Modelica model

    .. code-block:: modelica

       block IntegratorGain "Block to demonstrate the FMU export"
         parameter Real k = -1 "Gain";
         Modelica.Blocks.Interfaces.RealInput u "Input";
         Modelica.Blocks.Interfaces.RealOutput y1 
           "Output that depends on the state";
         Modelica.Blocks.Interfaces.RealOutput y2
           "Output that depends on the input";
         Real x(start=0) "State";
       equation
         der(x) = u;
         y1 = x;
         y2 = k*u;
       end IntegratorGain;

    The output will be as follows:

       >>> import os
       >>> import json
       >>> import buildingspy.fmi as f
       >>> fmu_name=os.path.join("buildingspy", "tests", "fmi", "IntegratorGain.fmu")
       >>> d=f.get_dependencies(fmu_name)
       >>> print(json.dumps(d, indent=2))
       {
         "Outputs": {
           "y1": [
             "x"
           ], 
           "EventCounter": [], 
           "y2": [
             "u"
           ], 
           "CPUtime": []
         }, 
         "InitialUnknowns": {
           "y1": [
             "x"
           ], 
           "EventCounter": [], 
           "y2": [
             "k", 
             "u"
           ], 
           "der(x)": [
             "u"
           ], 
           "CPUtime": []
         }, 
         "Derivatives": {
           "der(x)": [
             "u"
           ]
         }
       }
       
    '''
    import tempfile
    import os
    import zipfile
    import shutil
    import xml.etree.ElementTree as ET

    # Unzip the fmu
    dirNam = tempfile.mkdtemp(prefix='tmp-buildingspy-fmi-')
    zip_file = zipfile.ZipFile(fmu_file_name)
    zip_file.extract('modelDescription.xml', dirNam)
    zip_file.close()
    # Parse its modelDescription.xml file
    xml_file = os.path.join(dirNam, 'modelDescription.xml')
    tree = ET.parse(xml_file)
    shutil.rmtree(dirNam)
    root = tree.getroot()

    # Create a dict that links the variable number to variable name
    variable_names = {}
    variable_counter = 0
    for model_variables in root.iter('ModelVariables'):
        this_root = model_variables
        for child in this_root:
            variable_counter += 1
            variable_names[variable_counter] = child.attrib['name']

    # Read dependencies from xml and write to dependency_graph
    dependencies = {}

    # Get all dependencies of the FMU and store them in a hierarchical dictionary
    for typ in ['InitialUnknowns', 'Outputs', 'Derivatives']:
        dependencies[typ] = {}
        for children in root.iter(typ):
            #this_root = outputs
            for child in children:
                variable = variable_names[int(child.attrib['index'])]
                dependencies[typ][variable] = []
                for ind_var in child.attrib['dependencies'].split(' '):
                    if ind_var.strip() != "": # If variables depend on nothing, there will be an empty string
                        dependencies[typ][variable].append(variable_names[int(ind_var)])
    return dependencies
