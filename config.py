class Config:
    SECRET_KEY = 'B!1w8NAt1T^%kvhUI*S^'

class DevelopmentConfig(Config):
    DEBUG=True
    MYSQL_HOST = 'localhost'
    MYSQL_USER = 'hotelAdmin'
    MYSQL_PASSWORD = '666'
    MYSQL_DB = 'hotel'

config={
    'development': DevelopmentConfig
} 
