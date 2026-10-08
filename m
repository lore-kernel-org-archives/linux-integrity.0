Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011029.outbound.protection.outlook.com [52.101.57.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5A13CAE60;
	Thu,  8 Oct 2026 20:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791489641; cv=fail; b=mc4S90NszerqPShU2GUE9ac6JoouNRfOJwGxJQSPHyd9NN+QYN66CzvcK+KT60ezpC4gR34DYTHlUgvJHjFaUbJWK6cvDw9jiKHrkB/rjETN6g2nJ6RYEuiNjnGbrAnk6ktYjimkTlFt7RIOQWbJBxU8Xbx+Yl6thmQE8vHXILE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791489641; c=relaxed/simple;
	bh=2d18+bYP1DhvDvTjkiQoO6YDiV+3ed0eqyil9eZrmYE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tgB2ViP/FPhtIEKsdNcRbYm7g6dmS+HCm2pQIXBzCLdJxfzL06koZXzFB0pB68w1KlTnipjmSXw3wNSXR1zO8bnI0/BFq5L0C+qTqPvj/8mYaD2FoxRhkOSRDb24kK+lQyOOhGBmiVKUgLUAIxKyv1ByusWvlDnTi2spxi/Oy7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zYIE2aKp; arc=fail smtp.client-ip=52.101.57.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zYIE2aKp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wSSi318kaVIMCfR9lpH+oLutMeGhSJubfeOV4QH86SDUqzsPcXuzuLUNNqy3YfP1aCFwR8mZAlz5XyTj4VskNdXhitCcmyibZg/xeD9AmYI/Q7ulkJ8BN+LsIE6kpEDqa5APrUx/08y/wNbHLDXhSzKODNcYq4RFrZBCuarfdkNBmRARCKFckBLT7rsE8AdS7PKtf4nqzKHruIzVLH8zIGHjSnm837JiiHR2mo8Jj0nS6a4DT6S34z0V89M9zxugjKEEfeN50yeU6teBFrghgroDYb0RZjvw6NYxt65vWirBfWbt7jdGv1LEcMcAqLYEH2VukB6pzbvAzlHmzXwiAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cpAsVH98IXXQcHHn/lbyUBwRIzpzEYdn6/H6SsEpa7g=;
 b=DiyN9TDCzhvyT/PviNZXO8r6VO7GhIS2PgwNFnxSU6o7CD6rRvgSK52BQAiI+vx+kAHmFYNFb5AK0PE8s+TxkbloTqVxTDMtJRquXcxgR2fwshvkS+76J/SGiU2ubC8j9QqtViTk0oZXSLc3xB8EpDV7Vu79I9ef7uJNMvWD4QDGHh5ckZoCPgCl3v89dOuUJFP+n4MfadoOswF+HyqwX/jSAIZO+dpMnid0uYhTjYedZAXBxsJMTSB/XA5+mRBnegtg9owzQOQXK9YG1ZTl1XEYPkmEPgRMSVqpaNp7pX+6Xckj8nm1S/Xd8Xz2CdegNIW1MtgYkf5hyg9Oq/l+KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cpAsVH98IXXQcHHn/lbyUBwRIzpzEYdn6/H6SsEpa7g=;
 b=zYIE2aKpjxdHGvviQb0CGJ4duhtD2P2ZBK2Ct5QbDrKnOGVUs3pZ/pd6qPJwPZnohrvV4IkWWI0lAEVlxkmKzHum3kCbsWBRESI7UqNkWlZQ1dyn3je5E3oRtGWMbSGiF50ohLqnLBJ17Jpsica7ybar+/C2oFvAkFgQ4e4Tykk=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by CH2PR12MB9541.namprd12.prod.outlook.com (2603:10b6:610:27e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Thu, 8 Oct
 2026 20:00:31 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0496.010; Thu, 8 Oct 2026
 20:00:31 +0000
Message-ID: <ca2d299b-4153-4b0b-a60e-7fe64f9dbdef@amd.com>
Date: Thu, 8 Oct 2026 15:00:28 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] tpm_crb/Intel PTT: Late S3/S5/Reboot ACPI power management
 deadlock
Content-Language: en-US
To: Jarkko Sakkinen <jarkko@kernel.org>, Sean Meadows <Hellfire@unspacy.com>
Cc: linux-integrity@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
 rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org,
 Adam Alves <adamoa@gmail.com>
References: <bf3a9544-6e49-4d5d-a01a-f1912b717d08@unspacy.com>
 <aqyTpzk3jcarEMVS@kernel.org>
 <54425edf-3ca1-4f99-9166-40f9cc3dfff6@unspacy.com>
 <araNsEodZ3NXf9qT@kernel.org>
 <0e8f93d0-3da9-4af0-ac12-b3670acdcf79@unspacy.com>
 <arw609M6mDiqhQwJ@kernel.org>
 <723ff551-7852-4d57-ab1e-787a1a195759@unspacy.com>
 <asfXObGNaZ9Z8CwN@kernel.org>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <asfXObGNaZ9Z8CwN@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR16CA0019.namprd16.prod.outlook.com
 (2603:10b6:610:50::29) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|CH2PR12MB9541:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b3eaa2b-32ae-4b8f-d491-08df2576ce5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|18002099003|22082099003|4143699003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	nBr4o0qRSAHzQi9qhWZXud2MSyCpitNrgT3XSMCK6wv+EN6oO6dvKM5yKNW/CQvET8MxTC/WNF4IO/LtIsWqTg/vlAjnP8crZLC5RNriLTKyu87saPnASyXCxfaOKNy3g8vDgPvT655NlbtOj427DSQIlzdfOwznndoHVRTwkidzqaBsgSaRjhaSVcbeNFbxo2qt1qUKFXqnsSpsEhRUuXLsqx2YnnnED/g5PYxFlVHl85PO3nRvPzpjD1gXKpkoGnL5aez9VVm/6+C3o1Q+LWbOLafZb3UjIOmtl9WWF0rNdNAuDqRPthKLsFmtl8v1urKaMviUBB2PJ+Fxr7cn7FSgUgY+Nd6wu5dX6L4gvj+SusuxPVXABhjGNNhKZdascxwh2IlvfozivSGzVL1QT8H3S8kULpWEypl/0AmCvOaODBRY3M3Jo+nJYl8Q6MsfOfAV1tg6POkQN3I9Jj8rrBVenA7hO2w0fJBWM5DvgvQHhspkjbRmHNqphXBA0LBi1fiipXz9VGxDrbfimVR6F2vwZqZvmQaPRkI9HE01UIkGDiiUw8R1jryIvEWcW4YACB+tjY+WFOg3yU5u1TwWehKlZYbZEyy5WEHLcSU0NnN1Da1qoLkFtoVyxtwMnKta/5rsXP1LySqCpUmV1Ynw9n97xsRkISOwQpgU7B8do5Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(18002099003)(22082099003)(4143699003)(10067099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eDRuTDFWQUJjUm1IWkYvbE9SRmxvWWgxYmdIMSs5UEc4WG5ackpGbXQ4Y0NG?=
 =?utf-8?B?cGxmODF5SEhzOFozQ29YdFl5eHI2azRHaWpoSzZPQ0VFYXJ4V1ZFWjA2NGRQ?=
 =?utf-8?B?MVczdTl3NTQzdFU0UVZKMjVtYmxyRE9jU2JxRGZFQU4xSEVnbHhWcEthbFJj?=
 =?utf-8?B?SjBwRGZtM0VBUUlpUC9sS2I1RUIzVW1vZkttTGxlVWJBV1JCTmszOEdZOERY?=
 =?utf-8?B?Rnh4ZUFIalBXSHdlN3pYYXVhdjF4YU94SFF5SG9HZzFGRFJxNk9qNG5ZOXc5?=
 =?utf-8?B?MFh5eGpqMWJhK3JiaU0xNlVaWXRYdUwvK3p3ZFZ5djZCc2pMYkQvTXFYalMy?=
 =?utf-8?B?Z1V3dllleTV3TmNkK1dERUE3TjQzaU1EZ3VWK2hnYUMvTml5VnVCaTZwNWxT?=
 =?utf-8?B?UUhES2s5U1MvcXk4bVZqVGhxTHdrSG9MTUY4SWFOdnJoVWI2b0RtTGpPbUdr?=
 =?utf-8?B?UndQcnU1cFlzeWFYcWVrTEFRdThYVGNEUjZWVkVMRDV6MWkxWEFZR3ZIZlZX?=
 =?utf-8?B?ZkgyeGVubDBPY0tRQUlnQnBzTUdqam9RVTVpSExzVjBPakZWb0NqcnVTYTIy?=
 =?utf-8?B?SW15YmxEOU9qS2Q0eW85MmN3NTRjWjhlcXRFSk9abDRqaVA0WFlUdHZ0STcx?=
 =?utf-8?B?V09jME1OQzMyelNiRU9nTU1pRTd3di84T2RuVk50dzcyMUZIWUdjRE9LcUJp?=
 =?utf-8?B?c2dlUlg2clR4KzZ6eS8rYnR1WElQckIzOWNOdWtpNVlhazZMOWJZbEFmUGJM?=
 =?utf-8?B?WjdvVEs0T1JFUDVlSVR1VEdkQVNMcVdLdzRhclNyekVWZWNmdzVIZW1rTkMx?=
 =?utf-8?B?cndIeUh1VDFvMXBxUlZoVXlhaGhuSnY3UnVNU0I0TzN6RTN0NXNaYlZmMEYw?=
 =?utf-8?B?aGF5aDhNdndORDlNcGRWS0x2WWZBVDl6RXNrL0NWOXJSS2crY0QreXM3MDJJ?=
 =?utf-8?B?bUQ0bHpJeWNrUnNqL09aQUZuYkM5V3lpdU9WeUh6MEZuWDR5akV1TURzZWhk?=
 =?utf-8?B?dlBMbFNwaFNCZVhsQ0p0ZURaWHBKRC83d0hMWU1XT0FEb3hXLzVUT1lSazhV?=
 =?utf-8?B?OEsxc1dHOWl1ZFNYK21Nak1uVjNiZ3JtUEtPdy9ndTR2ZzV3aWplMmp4cW5S?=
 =?utf-8?B?ZDM4SHV5SzVmRWFWS2dGREZndUpLMkVLVktTbXh3V1h1WEZGMlIxelVMaXdE?=
 =?utf-8?B?OEJUNWwxTms5MU40Z3RUYzdHMXpMMUpUc2NOQmxwYjIyRmdLS3pBNG56am40?=
 =?utf-8?B?L3VqRXhQVERJZGVoWER6UGE2bmg1OVFCMXYvZlo3SDZJVTZLVFUvZW9TREwz?=
 =?utf-8?B?YSt2b1dQd3N0eVhsOVFkN2VMQ1pySTdKUnhDSFk1T0psV2Y2M1l5WGlxQlRD?=
 =?utf-8?B?UlRENWdxU0tSUmpxWmQ1eEE4ckdQcW9QWUpuOC9HYW9ZKzV4Vm1XNkdpdVRh?=
 =?utf-8?B?Q1I3ekVoZmhDclNWWTJlWGVaS1BDQ0RjcUo1SGdDZGlCRVNneG8yOGo5Y05m?=
 =?utf-8?B?ZU91aUtERVVIb1QwVmFWR0VQTUFLb3Y3c2ZvZjlrVEswYkUwWW92M05BemRM?=
 =?utf-8?B?OTNNVFBvOW5PVlJ0Ykx4R3MxNmJmVzIzY3gycCs2YStXQUJzY1FtZndUWVZj?=
 =?utf-8?B?SmtVR1V0aE9tY2pWaGk0aFJsK2NkVGpnazF5bUR5eXZVNUsydzg1MFYzQkxz?=
 =?utf-8?B?NDFoV1lMNDlqaXJMZ0V0dHozaUh1cCtWQmJGYjBla1ArNWI1WithdlVBT2VI?=
 =?utf-8?B?U3Z3cVl6NVVLRDAwemZPNHJ0WnBzYUgvd2J6NjFPblM4NkNiZnI0TkVENGh4?=
 =?utf-8?B?ZmVKRjYvM3d3TFRwT1dhUE82a2hNdGp6NU93bGErR0RwYzFjT3pXdEcyQ1FX?=
 =?utf-8?B?bGtLWHZ3RDRRRXgzcnVFWkVLbEFtcWdTajE5LzZkOXUvS3owVmdTN1hoeFRl?=
 =?utf-8?B?alRCSlkxUkFjVUJsOXZrRit6bjJiOXhpaG9ta1ZqbS90emU3Ymd5VE9SWmEz?=
 =?utf-8?B?VkYwOTBxUktNR1oyWGxKaUhKLzIzMW41VE5Ua3BJeDNWQm9JN2pIVUM5ZXRa?=
 =?utf-8?B?N05Obkt3dVFNZml6UjE2NUVwcktXUXpaQ3JlbkR3ck1MRUtyQm9ESDk5S0px?=
 =?utf-8?B?WkhZWVdQbXZUWWgySTh1NjI4eE1EMGhSd1ZUaE9LUFNQQ0Raa2ZlN0VYdGtC?=
 =?utf-8?B?dlJidFUrTW1oa0pzZnhTQnJyRkxSMlA2NTVsVE5xcDhiV2ZKTXFOV3pIRXR2?=
 =?utf-8?B?bzUyUDdXODJRMUc0L1FZZEVJU1dERkQxbkhibUxsMWVwTE1iRytTUVdFOU5L?=
 =?utf-8?Q?DPZ7JbrMdrZ2mhU8H7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b3eaa2b-32ae-4b8f-d491-08df2576ce5d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 20:00:31.0463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0cdkN34ogW5bXfPyc3QMl4ec5cf7M8wymkyZiVkL6IhiKd2aw4YTvKa+Ui5QT6FkDpT4BlTISv1o9ky+OqziCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9541



On 10/8/26 12:47, Jarkko Sakkinen wrote:
> On Wed, Oct 07, 2026 at 12:27:01PM -0400, Sean Meadows wrote:
>> On 9/29/26 18:25, Jarkko Sakkinen wrote:
>>> There's a commit with title "tpm: Call cmd_ready/go_idle for each command
>>> transmission", which is strongest contender to make a difference to this
>>> long running issue.
>>>
>>> I.e. I think it will improve firmware behavior given full release of
>>> resources per TPM command.
>>>
>>> I'm including it to v7.4 pull request.
>>>
>>> Br, Jarkko
>>
>> Hi Jarkko,
>>
>> I have to break some bad news.
>>
>> Testing Mr. Alves’s patch first led to a failure at the 60-hour mark.
>>
>> Mario’s patch—"tpm: Call cmd_ready/go_idle for each command
>> transmission"—failed at 55 hours.
>>
>> To give additional details: with Alves’ patch, I ported it forward and
>> tested it on kernel 7.2.7.
>>
>> With Mario’s patch, I downloaded the 7.3-rc5 mainline tree from Linus,
>> git-grabbed your tree to get the TPM patches, and then cherry-picked
>> Mario’s commit. It was applied and built without issue. If being cherry-
>> picked onto 7.3-rc5 left it deficient in some way, please let me know.
>>
>> I then proceeded to run 7.2.8 with my new USB3 debug cable.
>>
>> I initiated an S3 sleep after a fresh power-on to get a baseline. I have
>> complete logs saved, but I’ll simplify here to keep the message short
>> and succinct.
>>
>> 1. systemd-logind[483]: Lid closed.
>> 2. rtkit-daemon[648]: Successfully demoted thread 1001 of process 993.
>> 3. systemd-logind[483]: The system will suspend now!
>> 4. Kernel enters device suspend phase | driver callbacks | many lines of
>> confirmation as drivers and hardware transitioned
>>
>> 45 hours later, I tested the next S3 sleep and the following occurred:
>>
>> 1. systemd-logind[483]: Lid closed.
>> 2. rtkit-daemon[648]: Successfully demoted thread 1001 of process 993.
>> 3. Deadlock | USB3 DbC link drops immediately
>>
>> I don’t know what all can be captured through this debug cable, and this
>> next thought might be nonsensical as a result. Would you benefit from me
>> installing Windows and snooping on what the Microsoft TPM driver is
>> doing to prevent this deadlock?
>>
>> Thank you for your time and patience,
> 
> The patch I pointed out this in bugzilla but the patch I had in mind is:
> 
> "tpm: Call cmd_ready/go_idle for each command transmission"
> 
> Link: https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/commit/?id=9154aa6c4b789d23e59d599c330cab2c4e915401
> 
> The reason is that the commit message highlight a bit similar issues as
> reported in the bug.
> 
> Note commit IDs do change in my master branch so best is to look it up from:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/log/
> 
> Right another reason is that then the driver always the TPM in the state
> as it is when the driver starts.
> 
> I'm not sure about Windows but neither disregard it as sometimes we do
> pick behavior basing it on how Window does it. I'd still try Mario's
> patch at first.
> 
>>
>> Sean
> 
> Br, Jarkko

FWIW the issue my patch fixed manifested at bootup; but I definitely 
agree with Jarkko's hypothesis that it could apply to other TPM 
implementations and at different times.

When you tested Adam's patch I would like to point out it only 
automatically applies to one board: "TUF GAMING B460M-PLUS".

If that doesn't match your board you would need to set 
tpm.sleep_locality_preserve=1 for it to apply.

If you're sure my patch alone isn't enough to fix it you might try 
combining patches and setting that.

