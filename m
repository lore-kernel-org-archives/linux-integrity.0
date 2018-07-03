Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:18036 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752905AbeGCP1E (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 3 Jul 2018 11:27:04 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w63FOSUW094837
        for <linux-integrity@vger.kernel.org>; Tue, 3 Jul 2018 11:27:03 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2k09su636m-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 03 Jul 2018 11:27:03 -0400
Received: from localhost
        by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <jejb@linux.vnet.ibm.com>;
        Tue, 3 Jul 2018 09:27:02 -0600
Subject: Re: [PATCH 2/2] KEYS: trusted: Find tpm_chip and use it until
 module shutdown
From: James Bottomley <jejb@linux.vnet.ibm.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org, zohar@linux.vnet.ibm.com
Cc: jgg@ziepe.ca, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, dhowells@redhat.com,
        keyrings@vger.kernel.org
Date: Tue, 03 Jul 2018 08:26:55 -0700
In-Reply-To: <edf4aeaab76713579016cb009a0e632d7417c5f8.camel@linux.intel.com>
References: <20180626193040.2509798-1-stefanb@linux.vnet.ibm.com>
         <20180626193040.2509798-3-stefanb@linux.vnet.ibm.com>
         <edf4aeaab76713579016cb009a0e632d7417c5f8.camel@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1530631615.3142.6.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, 2018-07-03 at 18:24 +0300, Jarkko Sakkinen wrote:
[...]
> 
> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> 
> Is James maintaining this now? Have not seen his feedback yet...

Hey, I thought we both were ...

However, it looks fine to me

Reviewed-by: James E.J. Bottomley <jejb@linux.vnet.ibm.com>

James
