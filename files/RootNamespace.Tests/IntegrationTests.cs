﻿using Microsoft.Extensions.Configuration;
using Qonq.Medium.Client;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ${root_namespace}.Tests
{
    public class IntegrationTests
    {
        private readonly IConfiguration _configuration;

        public IntegrationTests()
        {
            _configuration = new ConfigurationBuilder()
                .SetBasePath(AppContext.BaseDirectory)
                .AddJsonFile("appsettings.json", optional: true, reloadOnChange: true)
                .AddUserSecrets<IntegrationTests>()
                .AddEnvironmentVariables()
                .Build();
        }

        [Fact]
        [Trait("Category", "Integration")]
        public async Task GetUserTest()
        {
            var isTrue = true;
            Assert.True(isTrue);
        }
    }
}