
class Fuzzify(object):
    def __init__(self, feature, data_series, dataset_mins, dataset_maxs):
        """Create a triangular membership function with a data series and its max, min and median"""
        
        self.data = data_series
        self.feature = feature
        self.low = dataset_mins[feature]
        self.high = dataset_maxs[feature]             
        self.mid = np.median(np.arange(self.low, self.high, 0.1))            
        self.universe = np.arange(np.floor(self.low), np.ceil(self.high)+0.2, 0.1)
        self.trimf_low  = fuzz.trimf(self.universe, [self.low, self.low, self.mid])
        self.trimf_mid = fuzz.trimf(self.universe, [self.low, self.mid, self.high+0.1])
        self.trimf_hi  =  fuzz.trimf(self.universe, [self.mid, self.high+0.1, self.high+0.1])
        
    def get_universe(self):
        return self.universe

    def view(self):
        fig, (ax0) = plt.subplots(nrows=1)
        ax0.plot(self.universe, self.trimf_low, 'b', linewidth=1.5, label='Bad')
        ax0.plot(self.universe, self.trimf_mid, 'g', linewidth=1.5, label='Decent')
        ax0.plot(self.universe, self.trimf_hi, 'r', linewidth=1.5, label='Great')
        ax0.set_title('Food quality')
        ax0.legend()
        plt.tight_layout()
        
    def get_membership(self):
        """Assign fuzzy membership to each observation in the data series and return a dataframe of the result"""
        
        new_df = pd.DataFrame(self.data)
        new_df['low'] = fuzz.interp_membership(self.universe, self.trimf_low, self.data)
        new_df['mid'] = fuzz.interp_membership(self.universe, self.trimf_mid, self.data)
        new_df['high'] = fuzz.interp_membership(self.universe, self.trimf_hi, self.data)
        new_df['membership'] = new_df.loc[:, ['low', 'mid', 'high']].idxmax(axis = 1)
        new_df['degree'] = new_df.loc[:, ['low', 'mid', 'high']].max(axis = 1)
        return new_df


def get_rule(train_data, *arg):
    """ return the final fuzzy rule given any number of input data columns"""
    
    rule_df = train_data.copy()
    rule_df['degree'] = np.ones(train_data.shape[0])
    for col in rule_df.columns[:-1]:
        idx = train_data.columns.get_loc(col)
        rule_df[col] = arg[idx]['membership']
        rule_df['degree'] *=  arg[idx]['degree']
    final_rule = rule_df.groupby(list(rule_df.columns[:-2])).max()
    final_rule = final_rule.reset_index()
    return final_rule

feature_names = ['age', 'cigsPerDay', 'totChol', 'sysBP', 'diaBP', 'BMI', 'heartRate', 'glucose']
target_name = 'TenYearCHD'
