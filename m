Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52642 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751208AbeDMQZO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 13 Apr 2018 12:25:14 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w3DGN6Ok051251
        for <linux-integrity@vger.kernel.org>; Fri, 13 Apr 2018 12:25:13 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2havqujptk-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 13 Apr 2018 12:25:12 -0400
Received: from localhost
        by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Fri, 13 Apr 2018 17:25:09 +0100
Subject: Re: [RFC PATCH v3 1/3] ima: extend clone() with IMA namespace
 support
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: linux-integrity@vger.kernel.org,
        containers@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, tycho@docker.com,
        serge@hallyn.com, sunyuqiong1988@gmail.com, david.safford@ge.com,
        mkayaalp@cs.binghamton.edu, James.Bottomley@HansenPartnership.com,
        Yuqiong Sun <suny@us.ibm.com>,
        Mehmet Kayaalp <mkayaalp@linux.vnet.ibm.com>,
        John Johansen <john.johansen@canonical.com>
Date: Fri, 13 Apr 2018 12:25:02 -0400
In-Reply-To: <87sh8lcecn.fsf@xmission.com>
References: <1522159038-14175-1-git-send-email-stefanb@linux.vnet.ibm.com>
         <1522159038-14175-2-git-send-email-stefanb@linux.vnet.ibm.com>
         <87sh8lcecn.fsf@xmission.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1523636702.3272.63.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

[Cc'ing John Johansen]

On Tue, 2018-03-27 at 18:01 -0500, Eric W. Biederman wrote:
[...]
> As such I expect the best way to create the ima namespace is by simply
> writing to securityfs/imafs.  Possibly before the user namespace is
> even unshared.  That would allow IMA to keep track of things from
> before a container is created.

My initial thought was to stage IMA namespacing with just IMA-audit
first, followed by either IMA-measurement or IMA-appraisal.  This
would allow us to get the basic IMA namespacing framework working and
defer dealing with the securityfs related namespacing of the IMA
policy and measurement list issues to later.

By tying IMA namespacing to a securityfs ima/unshare file, we would
need to address the securityfs issues first.

Mimi
