Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60198 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S968158AbdIZTKg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 26 Sep 2017 15:10:36 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v8QJA5pD028847
        for <linux-integrity@vger.kernel.org>; Tue, 26 Sep 2017 15:10:36 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2d7u8hcxgd-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 26 Sep 2017 15:10:36 -0400
Received: from localhost
        by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <kgold@linux.vnet.ibm.com>;
        Tue, 26 Sep 2017 13:10:35 -0600
Subject: Re: about context gap
Cc: linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
References: <20170916153540.w5lpsqz3cwpd3enx@linux.intel.com>
From: Ken Goldman <kgold@linux.vnet.ibm.com>
Date: Tue, 26 Sep 2017 15:10:32 -0400
MIME-Version: 1.0
In-Reply-To: <20170916153540.w5lpsqz3cwpd3enx@linux.intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <f3d04c67-5470-e167-d186-755a56edf059@linux.vnet.ibm.com>
To: unlisted-recipients:; (no To-header on input)
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On 9/16/2017 11:36 AM, Jarkko Sakkinen wrote:
> Hi
> 
> While sitting at the airport I started to think a bit about the context
> gap issue.
> 
> I think first thing that would make sense would be to have a 64-bit
> shadow count for every TPM space i.e.
> 
> atomic_long_t tpm2_ctx_cnt;
> 
> struct tpm2_space {
> 	/* ... */
> 	u64 ctx_cnt;
> };
> 
> For every create and load of a session you will read the global count
> and increase it. This way we have get a well defined order.
> 
> With this organization we could for example put tpm spaces to a
> red-black tree and refresh the oldest tpm space (just first thought
> that came to mind).

I think the algorithm is as follows:

1 - Each saved context has a sequence number.  It can either be 
extracted once and saved in a table or extracted from the context blob 
when needed.

2 - When a startauthsession or contextload returns the 
TPM_RC_CONTEXT_GAP error

2A - find the lowest context blob sequence number
2B - contextload it
2C - contextsave it

This is just for sessions, not objects.

~~

A fundamental design question is whether the application can call 
contextsave for sessions, or whether the command is reserved for the 
resource manager.

I personally think it adds a lot of complication - the session blob has 
to be sort of virtualized.  The use case - one application saving a 
session, then handing it over to another application that loads it - 
doesn't seem worth the complexity.

It should be discussed up front, because it affects the code.
