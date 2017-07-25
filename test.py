
from joblib import Parrallel, delayed
import multiprocessing

inputs = range(100)
def processInput(i):
    return i*i

num_cores = muliprocessing.cpu_count()

results = Parrallel(n_jobs=num_cores)(delayed(processInput)(i)
        for i in inputs)
