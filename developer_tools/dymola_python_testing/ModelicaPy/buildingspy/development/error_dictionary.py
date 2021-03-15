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
#!/usr/bin/env python
#######################################################
# Class that contains data fields needed for the
# error checking of the regression tests.
#
#
# MWetter@lbl.gov                            2015-11-17
#######################################################

class ErrorDictionary:
    ''' Class that contains data fields needed for the
        error checking of the regression tests.

        If additional error messages need to be checked,
        then they should be added to the constructor of this class.
    '''

    def __init__(self):
        ''' Constructor.
        '''
        self._error_dict = dict()
        # Set the error dictionaries.
        # Note that buildingspy_var needs to be a unique variable name.
        self._error_dict["numerical Jacobians"] = \
            {'tool_message'    : "Number of numerical Jacobians:",
             'counter'         : 0,
             'buildingspy_var' : "lJac",
             'model_message'   : "Numerical Jacobian in '{}'.",
             'summary_message' : "Number of models with numerical Jacobian                     : {}\n"}

        self._error_dict["unused connector"] = \
            {'tool_message'    : "Warning: The following connector variables are not used in the model",
             'counter'         : 0,
             'buildingspy_var' : "iUnuCon",
             'model_message'   : "Unused connector variables in '{}'.\n",
             'summary_message' : "Number of models with unused connector variables             : {}\n"}

        self._error_dict["parameter with start value only"] = \
            {'tool_message'    : "Warning: The following parameters don't have any value, only a start value",
             'counter'         : 0,
             'buildingspy_var' : "iParNoSta",
             'model_message'   : "Parameter with start value only in '{}'.\n",
             'summary_message' : "Number of models with parameters that only have a start value: {}\n"}

        self._error_dict["redundant consistent initial conditions"] = \
            {'tool_message'    : "Redundant consistent initial conditions:",
             'counter'         : 0,
             'buildingspy_var' : "iRedConIni",
             'model_message'   : "Redundant consistent initial conditions in '{}'.\n",
             'summary_message' : "Number of models with redundant consistent initial conditions: {}\n"}

        self._error_dict["type inconsistent definition equations"] = \
            {'tool_message'    : "Type inconsistent definition equation",
             'counter'         : 0,
             'buildingspy_var' : "iTypIncDef",
             'model_message'   : "Type inconsistent definition equations in '{}'.\n",
             'summary_message' : "Number of models with type inconsistent definition equations : {}\n"}

        self._error_dict["type incompatibility"] = \
            {'tool_message'    : "but they must be compatible",
             'counter'         : 0,
             'buildingspy_var' : "iTypInc",
             'model_message'   : "Type incompatibility in '{}'.\n",
             'summary_message' : "Number of models with incompatible types                     : {}\n"}

        self._error_dict["unspecified initial conditions"] = \
            {'tool_message'    : "Dymola has selected default initial condition",
             'counter'         : 0,
             'buildingspy_var' : "iUnsIni",
             'model_message'   : "Unspecified initial conditions in '{}'.\n",
             'summary_message' : "Number of models with unspecified initial conditions         : {}\n"}

        self._error_dict["invalid connect"] = \
            {'tool_message'    : "The model contained invalid connect statements.",
             'counter'         : 0,
             'buildingspy_var' : "iInvCon",
             'model_message'   : "Invalid connect statements in '{}'.\n",
             'summary_message' : "Number of models with invalid connect statements             : {}\n"}

        # This checks for something like
        # Differentiating (if noEvent(m_flow > m_flow_turbulent) then (m_flow/k)^2 else (if ....
        # under the assumption that it is continuous at switching.
        self._error_dict["differentiated if"] = \
            {'tool_message'    : "Differentiating (if",
             'counter'         : 0,
             'buildingspy_var' : "iDiffIf",
             'model_message'   : "Differentiated if-expression under assumption it is smooth in '{}'.\n",
             'summary_message' : "Number of models with differentiated if-expression           : {}\n"}

        self._error_dict["redeclare non-replaceable"] = \
            {'tool_message'    : "Warning: Redeclaration of non-replaceable requires type equivalence",
             'counter'         : 0,
             'buildingspy_var' : "iRedNon",
             'model_message'   : "Redeclaration of non-replaceable class in '{}'.\n",
             'summary_message' : "Number of models with redeclaration of non-replaceable class : {}\n"}

        self._error_dict["experiment annotation"] = \
            {'tool_message'    : "Warning: Failed to interpret experiment annotation",
             'counter'         : 0,
             'buildingspy_var' : "iExpAnn",
             'model_message'   : "Failed to interpret experiment annotation in '{}'.\n",
             'summary_message' : "Number of models with wrong experiment annotation            : {}\n"}

        # This is a  test for
        #  Warning: Command 'Simulate and plot' in model 'Buildings.Airflow.Multizone.BaseClasses.Examples.WindPressureLowRise',
        #  specified file modelica://Buildings/.../windPressureLowRise.mos which was not found.
        self._error_dict["file not found"] = \
            {'tool_message'    : "which was not found",
             'counter'         : 0,
             'buildingspy_var' : "iFilNotFou",
             'model_message'   : "File not found in '{}'.\n",
             'summary_message' : "Number of models with file not found                         : {}\n"}

        self._error_dict["stateGraphRoot missing"] = \
            {'tool_message'    : "A \\\"stateGraphRoot\\\" component was automatically introduced.",
             'counter'         : 0,
             'buildingspy_var' : "iStaGraRooMis",
             'model_message'   : "\"inner Modelica.StateGraph.StateGraphRoot\" is missing in '{}'.\n",
             'summary_message' : "Number of models with missing StateGraphRoot                 : {}\n"}


    def get_dictionary(self):
        """ Return the dictionary with all error data
        """
        return self._error_dict

    def increment_counter(self, key):
        """ Increment the error counter by one for the error type defined by *key*.

        :param key: The json key of the error type.
        """
        self._error_dict[key]["counter"] = self._error_dict[key]["counter"] + 1

    def keys(self):
        """ Return a copy of the dictionary's list of keys.
        """
        return sorted(self._error_dict.keys())

    def tool_messages(self):
        """ Return a copy of the tool messages as a list.
        """
        ret = list()
        keys = self.keys()
        for key in keys:
            ret.append(self._error_dict[key]['tool_message'])
        return ret
