Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057813EDABA;
	Tue,  4 Aug 2026 19:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785870505; cv=fail; b=cYJeIMgdj5bQYKl2dE1pfStkIhY3JLu3vkqldwgF/hbDI/DbSVYpRPfQufzMt+ZAO6VAS56Mm1f6d6SXKQDoTSZraM03s+xh3yNCKw2oVjYeejlEUy6/7pL2At3NCcTTzVO8NPr7wuTHDO42HLMJiMNiHQJMvtqmcwWB6hqmPKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785870505; c=relaxed/simple;
	bh=F84QkVYM6gVoRyV8qm109YMZ2Mzr6iElU5iZYnZdiic=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lSrwA7QruavoJqxQa7K4QQXcKSJ78OPq+XgeDVs7j6CyiPxIETawD1M66P/hF4opoTUFJfnF6kbzJUfiYKEWsdY8kBDPQaFAPwAr2OV/sbVSklSYyllXpX69lxNfdYfRv3AJSE5YSuD+iv8zuD/rmVUkA7Gf3Tyy1YoYizRz478=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dO00Sb1C; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dO00Sb1C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785870505; x=1817406505;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=F84QkVYM6gVoRyV8qm109YMZ2Mzr6iElU5iZYnZdiic=;
  b=dO00Sb1CebTusERMHiFXNImvmvmoNJ6x0pEkmUK7JrH4NFh2LkAvzaIj
   FkXW9WF5gK3E5NXhSA2hEMqCEon5J1wpTJ4sjAAreqyrxvHYncdRhTrlx
   /yxjq8Z9wZPwJEHpghwwZtxtEswkYqB4foRFOXRgi66A50PgCtaZ3JSzl
   Q+ge0OfrSXqqZyq12u3aKwtz6+ayunrU5bcgHqEngjbwhtObrS1Kx6cj2
   +PDIoO/4I50sT0OBqy2X82llOo5C3EEpGS0eSqlGd9lc7pU8cUaU2OjIN
   Mba07iCr81IbAzDCf1fVJIY9xEAW0oZeXXQADEY7Jdfg1xIdY5Zomo3Ds
   w==;
X-CSE-ConnectionGUID: h506i6h0TKehNBPbhhuXjQ==
X-CSE-MsgGUID: QZ1pVKwkR9yho0fjLQbYYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="90317786"
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="90317786"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 12:08:24 -0700
X-CSE-ConnectionGUID: t6h5RBq0TZiNZX/dadjYeQ==
X-CSE-MsgGUID: QD6bvCL9QYakyUWq4cxxgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="291531239"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 12:08:24 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 4 Aug 2026 12:08:23 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Tue, 4 Aug 2026 12:08:23 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.33) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 4 Aug 2026 12:08:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jf9xGsg7ttztrgPSrkW6Z5WMNfDtnisorW2ED7vAyNzM3dbs7koDuYkvDt+pKqe7GpuMjv1j9UrQFTKHbVgb4eP15a/ZBXlE6SKy+fzuEjaEfK2k8GybhQ2U3mST4c2llbFlwt7EgUFK7IRdSqmxbShy4Dxfyy0z9QAEInR1pUEE/020PyiL+2K/H5tN44LgBRYRq2052892wOfxuI0uhIabi4nD5D8xAKREcMKWQzItU7iXoCT6YNUfk0e9z3xDZcyJDUvamve60gbIefXKKpSYgJxR+Xhp4LrD8Wa3MJXO0vxZ5JuBuOKA+975OSEwSh5iJIRfT4uvpXU5+w5Ilg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ni2SowPyFdgCp4urnzq/9Ktb7JcafkOjkRMKVVbRXYw=;
 b=HcuoxWcjgI2a1tWJ7FpZ83wq34MMMcZm476lqO7BCAryp/vYCQHfmsBEVB9fhqZhiznRZy+wkrZEpJU25vfGTluIRCq6Oy3pTMWE/U+HTj8Ub2d61AUC/ay4oZc8f8Va9XtonXhRaiW+iauQNanNjJA4IRYfg3A7cIxabIOth0B8LlVvuwGsws5OyKFFklGgGiHmmOSwr42z8twBrPpHz9xRX18Sud0FivqAnLjPJY0Gr3Q2Z+JFt5MrsHrEmf2fa3J/XsO7plOe7M1AVipfZqnbxH0ZU3ebKkyaavidHBPHmftDqcyEC82R0lRq6UYwIH7UCFevj2WjGeyQEqlq+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f27) by CH2PR11MB8836.namprd11.prod.outlook.com
 (2603:10b6:610:283::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.16; Tue, 4 Aug
 2026 19:08:15 +0000
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::ed8b:1455:8b29:144c]) by DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::ed8b:1455:8b29:144c%7]) with mapi id 15.21.0270.017; Tue, 4 Aug 2026
 19:08:15 +0000
Message-ID: <f42cc94c-ff60-4999-b473-c2fc5b1b4199@intel.com>
Date: Tue, 4 Aug 2026 21:08:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] no TPM device after "tpm_crb: Convert ACPI driver to
 a platform one"
To: Julien <julien82453@gmail.com>
CC: <regressions@lists.linux.dev>, <jarkko@kernel.org>,
	<linux-integrity@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
References: <CAJOGg3z6LJPDsdPNBxajgy8_wQxfhYBRxe4EiurZf3kPU5A5Bw@mail.gmail.com>
Content-Language: en-US
From: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
In-Reply-To: <CAJOGg3z6LJPDsdPNBxajgy8_wQxfhYBRxe4EiurZf3kPU5A5Bw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA0P291CA0019.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::21) To DM3PPF63A6024A9.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f27)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PPF63A6024A9:EE_|CH2PR11MB8836:EE_
X-MS-Office365-Filtering-Correlation-Id: cbddd751-3288-4d0c-3d4a-08def25bbc7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|6133799003|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: +Di5rhMJS4qhNo8/tDZV+wD0eGVpk4vprrScuHeVNcwqMxgNwolnrbCN8nyyvr93fgiLw2BSdzncmgnw6qXQzQ2vV5G9Np2QOr6Rtpjplee2+wSkhZVqtyARE0VZz6MQ1QU6AcLmcLFke1gdHRtH8F4MOZdHNMtIApBgP9X2o0Q+AbyK4ntsyGes0jv3OXaqVL/RkBLwKDmTgwHvTverivEFKARZOWct5ZcRkatKmI0msaTao2UUPJ4JRhqVGDXZYmTvDcAdfW3nXrREGvcnnPKqjRS5IxA2kDAG/Kv2TluSdRbM94oAysvE39wgAwnhC6XpeKbEXaKh9X7UbxCnJ/X1ysX9r7a3Vk7KACufywcUBtF7mNdN8PJv4safa0IGXP5wE8IhSalHdsW1uD+LA4HRvmYlC1vLbEn8keeyesZ/fX3a1fPRp9fuXMRx4jPrdL7TSYxorzJnUlep8f78X7LmfLU0AyESZzNKfhMnHDFKsO0QIMIPZKXZDtezb77sqVM3R+/x541zdguaeDPdSOT8q/DEyjnQr22mXRb0DneDiAxhOsnbfTeXbmPtt/0k9TdhC75tEq8EjPWFRwlpup9ZDZo8yWrLn2FBlzi13O1sJH5v1a/ggWvu41S8W8Hb+1b52f/RAADiR9op9R6d7i4kdcg65jF8/LM62yt/tAE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PPF63A6024A9.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(6133799003)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VEpzS245MCt3aU8rbm5iYldjanQrbTJQK2oxSEt6VEJoRVhDVkU0RnVxVlFR?=
 =?utf-8?B?cE1LalFncmNGbEhyTGpMcU5wdDh4SU9zZmJCK0R0SDF4cE03dFlEZ3pxbEV5?=
 =?utf-8?B?TGgzaUw4eS9aK2JUTW05Y2t3TUw1Z0JmQmlGRlNTSDJzZlR3K1VHMVBHSzMz?=
 =?utf-8?B?Q2xheDZYT2k3Nnhpam11QWF0eUJrbXNHazg3YUl2TEFRdS9oZzIvNWNXUlhJ?=
 =?utf-8?B?b3JyeVJrQ3RtWS96dTFQdG1pNS9FT3owcTVMUElvRXRPbUV2aDlmWjNkWjI3?=
 =?utf-8?B?SCtrWUZsTFYwc2tNVmpUQWhiS1VId3BDUGp1MTdRMnpsbjFEeGFjWGpuUitl?=
 =?utf-8?B?UnlIdytmZVFlQVhGWmlFckszRGpSRXlRU0VJNTZiNDZRdlY2REwvWmYrY09Q?=
 =?utf-8?B?dEwxTUtDTWwvKzh3VUwrc3NlUXppbjFMZUp1SU5GK0hla1VDYm0wNzROckZT?=
 =?utf-8?B?ZVpYbzlHSnlLam1ZWDBCdms2STQ2V1ZPL2hxRGR0RmpoeEJCWU5CRjJBSHoy?=
 =?utf-8?B?WHlLRkRuMTV0cHczc1FhN2VSbVYySmhmWXJLdUZ3eW1iNUQwZXdubkZ1b2Vz?=
 =?utf-8?B?b2liVkFJOG5PdjNDdXZmTUJYUXRicURkUExMTS8yWUFlUzNla0lhK0pJdktQ?=
 =?utf-8?B?V0Fjd2E1T1NOTVFuQ2M0NGZTb3RmZitCUXZJLzdJK0c3WEc5a3d5eVRpMXdU?=
 =?utf-8?B?cXVFaFJ4YlJiczNmQkZjdzFBV1ZocXVDWXJzaFdFV2lKeGd3MkZTS3BYNUo0?=
 =?utf-8?B?WlRxd29jUVYxajUrRm1kRXNvRXZ2S1FHTnNlREl4bW9GNENaNFZyVDNnRGZ1?=
 =?utf-8?B?ZWIvWGV0c1ZLK1VhbnpXMTFpVFZWUzZ1WTRGTiswN3FqMXd2NVRwVm1yeWRS?=
 =?utf-8?B?ZkdRODRkczVRcnpQa01aM205aGpDY1Z4TnZhTnIvWEptSG4rR0NBeEZ6akVJ?=
 =?utf-8?B?L2JMditkTk54WDU5dVF5U2hTRHE4VWk5L0l2clFudlhOQWhodzlKU0EvWW9U?=
 =?utf-8?B?REFIL3lYSUlFSDdiSm1remlWaWJrc0VaU1J4bG1zd0xwWjN5R1NzZFN4LzVF?=
 =?utf-8?B?UnVNWXBmVm0rYjVJNGI1d1NIQXlZaUg5Zll5Q1oxVDVPbzgwUG1rdzZSSlB6?=
 =?utf-8?B?WFNIWUdMRDdqVVZoSlhQSEJZdUdyUVhVV09MTkoxZ01GUDhIeXhncGl4TUQz?=
 =?utf-8?B?T0V6ejYwbXFVMWJmUkVpU2lxSW9oOVZ3OHVOMVRGWmJLM2ZoK1F2cGNhdStR?=
 =?utf-8?B?QVFROEFmQmFwd2N0d2RLUTEwZDI0L1NTUHZkK0xndGdJdXVqMXhXcHFzYUZP?=
 =?utf-8?B?MjBhUE5sQVd2blZ4UUJMNytMTCtvYmtmTDhPOHZUYVA0amwyUFZkUU03S0hV?=
 =?utf-8?B?NG1Oa3d6N2trY0cvSk5TWjlpbGJucHkzTnBvalk0T2ZLMUQ2V2tVNTdwQWM5?=
 =?utf-8?B?Vm1oQkRLUWdJTVB0T084OWUwa1I1T0lOZzZzd0d1U3AyNUxZZ3pldXlrNnpt?=
 =?utf-8?B?V001RFY1UEF5RldhV3lyOE03SFBHSXVTRlJkYklKK0JhbEVwVjR5SGNIQm9h?=
 =?utf-8?B?VDRSbUxuWThaRGNFUGRPUDdmMjQ3RWxQM0NmMHFZaTU0bVNKQXpRaERWdjh0?=
 =?utf-8?B?UEFRd2ZNc1N2cE8xcGdPR2ZpWTRVdW14bHU2cEF1cDIwWnJteXBwTjZCR1RO?=
 =?utf-8?B?NWJpUDN0M1ovTGZPTUhqOE1BOVEwemRGbWJoWmdNSGs3ZXlqZFJxU2xyamJn?=
 =?utf-8?B?WWQzWmVsUzZldnV2N1NGYUxERWV1bmdxZ0U3RTAyRzBMLzZiaVkvY2tqaEpM?=
 =?utf-8?B?dzVWaTJKK29KdEs4cUc5ZWNVcUs3MGJ1TzlwbWk0TzEwVnpyV2w0L3hGUkw2?=
 =?utf-8?B?RHgwMTd1TC9JSy9QdXZjeWtMSDhDWGNQVHY2dmcvc3NOVGdvempjVkZCaTNF?=
 =?utf-8?B?b2NBSDZOTVpNeHRtVHoyb0xhMnJ1MGplMTFVUWk2ZVpnN2tQMGlHdlhzU1h3?=
 =?utf-8?B?N28xTDZ6MVZ3OG1xTEs0T2hPSVE1RTdCR3hweXJBSUNYcXpVZlRJQ2RYUnI2?=
 =?utf-8?B?eXYzNW96d1J6NFJZR1lRQnFBRDllSjQ4VmpTTmRjNFdSQXh6MjlUOFcxdGpx?=
 =?utf-8?B?cnlzWEVGMGp6UUZmVlpXRmVUMkJpZ2hyUHhHS2FDZWRuamJtMEVmYTJwUkZ3?=
 =?utf-8?B?VkZWa0YwaE8xL1pPOEZmNVFaTFJ2S3JQQk5XMmhpczB2VVdoMFowRUxPWUNl?=
 =?utf-8?B?SEdhRSs2UEpJeW5oUVpGSWlWSFJQM1R0Y05XOWFNbXM1UVFlS3o3d09hQStu?=
 =?utf-8?B?bXRkWk42Y1lXM2tESHdxTmMvUkZrd25LeWg3U0tIbEtXT05FYWkyWFk3RGZD?=
 =?utf-8?Q?gegEMxGargntc0I0=3D?=
X-Exchange-RoutingPolicyChecked: Lxw7nRrTouN5+J/EgdRFucrYq9FFA5ImmRlYI9ZOUJlBBDvLZQsRiI8R5K29ezqB5z1ZXR9gnmmHtPTEtncFQY1Ghm5ni0OSYHzOB3wMCeCEA4wY+CwMECm9gHZi8iC/C/IY9vOtu7RUlSGloa+uIsjZTlz+aYyrW7C2+jxvLgOfPSLkl3ehsjc5bkqNREHx5l5CLKiJ+7n0ADuwiheQ+3GmlmlZENMpG5R1fDazTi71gHfxpO9gkF7WNFfkhScn+2gp2DDdZXt9vc1V8eF0Ew0G1GtP0te9LfNAYa0dmJJc9K09IfGm60trXudF1f0R0AIqalsjkPfzXWkWttT57A==
X-MS-Exchange-CrossTenant-Network-Message-Id: cbddd751-3288-4d0c-3d4a-08def25bbc7c
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF63A6024A9.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 19:08:15.3330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wLnI+bgj7Dh9viWDk5ts1HbqtH4VshKYpHvDVf0nlZSkvekb6pVChiax2EMeGSxuf7gK+gqdBi35mdnzuh2Xz7ZhYrs8qCXeMpteGrw29q4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB8836
X-OriginatorOrg: intel.com

Hi,

On 8/2/2026 2:54 PM, Julien wrote:
> Hello,
>
> Please keep in mind this is my first time reporting a Linux kernel 
> regression.
>
> Since commit 48fe2cddc85c ("tpm_crb: Convert ACPI driver to a platform 
> one"), my TPM device is no longer available. Both /dev/tpm0 and 
> /dev/tpmrm0 are missing.
>
> Log messages:
> platform MSFT0101:00: failed to claim resource 1: [mem 
> 0xfed40000-0xfed40fff]
> acpi MSFT0101:00: platform device creation failed: -16
>
So there's no platform device for the driver to bind to.

I think that these messages have been present in the kernel logs for 
quite some time, but previously they were not connected to any 
functional issues.


> I added some debug logging:
> ACPI resourcet[0] = [mem 0xfed40040-0xfed4103f flags 0x200]
> ACPI resourcet[1] = [mem 0xfed40000-0xfed40fff flags 0x200]
>
> I think the failure happens in kernel/resource.c: __insert_resource() 
> because of the two memory regions overlapping.
>
This is quite plausible, but if that's the case, it should be fixable.

Let me figure out something.


> I am attaching the TPM SSDT and the SDDT defining PTTB ACPI variable 
> address.
> The value of PPTB
> dd if=/dev/mem bs=1 skip=$((0x8AE5CFDC)) count=8 | hexdump -C
> 40 00 d4 fe 00 00 00 00
>
> Hardware information:
>   Manufacturer: Acer
>   Model: Aspire ES1-572
>   BIOS vendor: Insyde Corp.
>   BIOS version: V1.16
>   BIOS date: 09/18/2018
>
> Thanks
>
> #regzbot introduced: 48fe2cddc85c
>
