import fastroute_problem as frp
import solver 
import os
import amplpy

from importlib import reload
reload(solver)

class FrpAmplMipSolver(solver.Solver):

    def __init__(self):
        super(FrpAmplMipSolver, self).__init__()
        self.problem = frp.FastRouteProb
        self.matrice = frp.FastRouteProb.__str__(self.problem())

    def solve(self, prob=None):
        try:
            ampl_env = amplpy.Environment()
            ampl = amplpy.AMPL(ampl_env)

            ampl.setOption('solver', 'gurobi')

            model_dir = os.path.normpath('./ampl_models')
            ampl.read(os.path.join(model_dir, '/ampl_m.mod'))

            departs=['1','2','3','4']
            arrivees=['1','2','3','4']

            df = amplpy.DataFrame('depart')
            df.setColumn(self,'depart')
            ampl.setData(df, departs)

            df = amplpy.DataFrame('arrivee')
            df.setColumn(self,'arrivee')
            ampl.setData(df, arrivees)

            df = amplpy.DataFrame(('depart','arrivee'), 'dst')

            df.setValues({
                (depart, arrivee): self.matrice[i][j]
                for i, depart in enumerate(departs)
                for j, arrivee in enumerate(arrivees)})

            ampl.setData(self, df)
            ampl.solve()
            self.done = True


            print('Objective: {}'.format(ampl.getObjective('Total_Cost').value()))
            solution = ampl.getVariable('Buy').getValues()
            print('Solution retournée: \n' + str(solution))

        except Exception as error:
            print(error)
            raise
