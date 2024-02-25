
import os
import pytest
import pandas as pd
from sklearn.model_selection import train_test_split

from real_estate_price_prediction import DataLoader, DataPreprocessor, PropertyPricePredictor


ROOT_DIR = os.path.dirname(os.path.dirname(os.path.abspath("real_estate_price_prediction.py")))

data_path = os.path.join(ROOT_DIR, "data/Property_with_Feature_Engineering.csv")

@pytest.fixture
def data_loader():
    return DataLoader(data_path)

@pytest.fixture
def df(data_loader):
    return data_loader.load_data()

def test_load_data(data_loader):
    # Load data using DataLoader
    loaded_data = data_loader.load_data()

    # Assert that the loaded_data is a pandas DataFrame
    assert isinstance(loaded_data, pd.DataFrame)

@pytest.fixture
def data_cleaner(data_loader, df):
    # Test cleaning functionality
    cleaned_data = data_loader.clean_data(df)
    return cleaned_data


def test_clean_data(data_cleaner):

    # Test cleaning functionality
    cleaned_data = data_cleaner
    # Assert that the cleaned_data is a pandas DataFrame
    assert isinstance(cleaned_data, pd.DataFrame)

    # Check if unnecessary property types are dropped
    assert 'Villa' not in cleaned_data['property_type'].values

    # Check if excluded cities are dropped
    assert 'Lahore' not in cleaned_data['city'].values

    # Check if locations not in the specified list are dropped
    assert 'Gulshan' not in cleaned_data['location'].values

    # Check if excess columns are dropped
    excess_columns = ['property_id', 'location_id', 'page_url', 'province_name', 'locality',
                      'latitude', 'longitude', 'area', 'area_marla','purpose', 'date_added',
                      'day', 'agency', 'agent']
    assert all(col not in cleaned_data.columns for col in excess_columns)

    # Check if year and month fields are converted to string
    assert cleaned_data['year'].dtype == 'object'
    assert cleaned_data['month'].dtype == 'object'

    # Check if only data for July 2019 is retained
    assert all((cleaned_data['year'] == '2019') & (cleaned_data['month'] == '7'))

    # Check if index is reset
    assert cleaned_data.index.equals(pd.RangeIndex(start=0, stop=len(cleaned_data), step=1))



def test_preprocess_data(data_cleaner):

    # Create DataPreprocessor instance
    data_preprocessor = DataPreprocessor(data_cleaner)

    # Test preprocess functionality
    preprocessed_data = data_preprocessor.preprocess_data(data_cleaner)

    # Assert that the preprocessed_data is a pandas DataFrame
    assert isinstance(preprocessed_data, pd.DataFrame)
     # Assert that 'location' strings are stripped of leading/trailing whitespace
    assert all(location == location.strip() for location in preprocessed_data['location'])

@pytest.fixture
def property_price_predictor():
    return PropertyPricePredictor(data_path)

def test_load_and_preprocess_data(property_price_predictor):
    X, y = property_price_predictor.load_and_preprocess_data()

    # Assert that X and y are pandas DataFrames or Series respectively
    assert isinstance(X, pd.DataFrame)
    assert isinstance(y, pd.Series)

def test_train_model(property_price_predictor):
    X, y = property_price_predictor.load_and_preprocess_data()

    # Split the data into train and test sets
    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

    # Train the model
    property_price_predictor.train_model('linear_regression', X_train, y_train)

def test_evaluate_model(property_price_predictor):
    X, y = property_price_predictor.load_and_preprocess_data()

    # Split the data into train and test sets
    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

    # Train the model
    property_price_predictor.train_model('linear_regression', X_train, y_train)

    # Evaluate the model
    mse, mae, rmse, variance_score = property_price_predictor.evaluate_model(X_test, y_test)